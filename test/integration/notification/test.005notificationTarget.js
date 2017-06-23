var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

test({
  type: 'integration',
  name: 'Notification target',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Fetch notification targerts',
      method: 'notification.notificationTarget.fetch',
      params: (context) => {
        return {
          notificationTargetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          notificationTargetId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check fetched notification targets')
      }
    },
    {
      name: 'Get notification status',
      method: 'notification.notificationTarget.get',
      params: (context) => {
        return {
          notificationTargetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          notificationTargetId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check gathered notification target')
      }
    }
    ])
  }
}, module.parent)
