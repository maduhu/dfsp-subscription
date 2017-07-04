var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

const EDITED_CONTENT = 'Edited notification template'

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
      method: 'notification.template.fetch',
      params: (context) => {
        return {
          templateId: 1
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
      method: 'notification.template.get',
      params: (context) => {
        return {
          channelId: 1,
          operationId: 1,
          targetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          templateId: joi.number(),
          name: joi.string(),
          channelId: joi.number(),
          operationId: joi.number(),
          targetId: joi.number(),
          content: joi.string()
        }).required()).error, null, 'Check gathered notification templates')
      }
    },
    {
      name: 'Edit notification template',
      method: 'notification.template.edit',
      params: (context) => {
        return {
          templateId: 1,
          content: EDITED_CONTENT
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          templateId: joi.number(),
          name: joi.string(),
          channelId: joi.number(),
          operationId: joi.number(),
          targetId: joi.number(),
          content: joi.string()
        }).required()).error, null, 'Check editted notification template')
        assert.equals(result.content, EDITED_CONTENT, 'Content was not edited!')
      }
    }
    ])
  }
}, module.parent)
