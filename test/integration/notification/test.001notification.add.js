/* eslint no-template-curly-in-string:0 */
var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

const TEMPLATECONTENT = 'You have received ${amount} ${currency}!'
const DESTINATIONS = ['bob01', 'bob02', 'bob03']

test({
  type: 'integration',
  name: 'Notification',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Create temple if there is not',
      method: 'notification.notificationTemplate.fetch',
      params: (context) => {
        return {}
      },
      result: (result, assert) => {
        if (result.pagination.recordsTotal < 1) {
          bus.importMethod('notification.notificationTemplate.add')({
            name: 'Test 101',
            notificationChannelId: 1,
            notificationOperationId: 1,
            notificationTargetId: 1,
            content: TEMPLATECONTENT
          })
        }
      }
    },
    {
      name: 'Add notification',
      method: 'notification.add.execute',
      params: (context) => {
        return {
          notificationChannelId: 1,
          notificationOperationId: 1,
          notificationTargetId: 1,
          destinations: DESTINATIONS,
          params: '{"amount": 5, "currency": "USD"}'
        }
      },
      result: (result, assert) => {
        assert.equals(result.addedRecords, DESTINATIONS.length.toString(), 'Check the count of the inserted notifications')
      }
    },
    {
      name: 'Fetch notification',
      method: 'notification.notification.fetch',
      params: (context) => {
        return {
          notificationTemplateId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          data: joi.array().items({
            content: joi.string(),
            createdOn: joi.string(),
            destination: joi.string(),
            notificationId: joi.number(),
            notificationStatusId: joi.number(),
            notificationTemplateId: joi.number(),
            params: joi.object().keys({
              amount: joi.number(),
              currency: joi.string()
            }),
            updatedOn: joi.string()
          }).required(),
          pagination: joi.object().keys({
            pageNumber: joi.number(),
            pageSize: joi.number(),
            pagesTotal: joi.number(),
            recordsTotal: joi.number()
          })
        }).required()).error, null, 'Fetch notifications')
      }
    },
    {
      name: 'Edit notification',
      method: 'notification.notification.edit',
      params: (context) => {
        return {
          notificationId: context['Fetch notification'].data[0].notificationId,
          notificationStatusId: 2
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          content: joi.string(),
          createdOn: joi.string(),
          destination: joi.string(),
          notificationId: joi.string(),
          notificationStatusId: joi.number().valid(2),
          notificationTemplateId: joi.number(),
          params: joi.object().keys({
            amount: joi.number(),
            currency: joi.string()
          }),
          updatedOn: joi.string()
        }).required()).error, null, 'Edit notification')
      }
    }
    ])
  }
}, module.parent)
