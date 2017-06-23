var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

test({
  type: 'integration',
  name: 'Notification template',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Fetch notification templates',
      method: 'notification.notificationTemplate.fetch',
      params: (context) => {
        return {
          notificationTemplateId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          data: joi.array(),
          pagination: joi.object().keys({
            pageNumber: joi.number(),
            pageSize: joi.number(),
            pagesTotal: joi.number(),
            recordsTotal: joi.number()
          })
        }).required()).error, null, 'Check fetched notification templates')
      }
    },
    {
      name: 'Get notification template',
      method: 'notification.notificationTemplate.get',
      params: (context) => {
        return {
          notificationChannelId: 1,
          notificationOperationId: 1,
          notificationTargetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          notificationTemplateId: joi.number(),
          name: joi.string(),
          notificationChannelId: joi.number(),
          notificationOperationId: joi.number(),
          notificationTargetId: joi.number(),
          content: joi.string()
        }).required()).error, null, 'Check gathered notification templates')
      }
    }
    ])
  }
}, module.parent)
