var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

test({
  type: 'integration',
  name: 'Notification operation',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Fetch notification operations',
      method: 'notification.notificationOperation.fetch',
      params: (context) => {
        return {
          notificationOperationId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          notificationOperationId: joi.number(),
          name: joi.string(),
          description: joi.string(),
          params: joi.array()
        }).required()).error, null, 'Check fetched notification operations')
      }
    },
    {
      name: 'Get notification operations',
      method: 'notification.notificationOperation.get',
      params: (context) => {
        return {
          notificationOperationId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          notificationOperationId: joi.number(),
          name: joi.string(),
          description: joi.string(),
          params: joi.array()
        }).required()).error, null, 'Check gathered notification operation')
      }
    }
    ])
  }
}, module.parent)
