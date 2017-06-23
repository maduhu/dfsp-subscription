var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

test({
  type: 'integration',
  name: 'Notification status',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Fetch notification statuses',
      method: 'notification.notificationStatus.fetch',
      params: (context) => {
        return {
          notificationStatusId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          notificationStatusId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check fetched notification statuses')
      }
    },
    {
      name: 'Get notification status',
      method: 'notification.notificationStatus.get',
      params: (context) => {
        return {
          notificationStatusId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          notificationStatusId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check gathered notification status')
      }
    }
    ])
  }
}, module.parent)
