var test = require('ut-run/test')
var config = require('../../lib/appConfig')
var joi = require('joi')

test({
  type: 'integration',
  name: 'Notification channel',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Fetch notification channels',
      method: 'notification.channel.fetch',
      params: (context) => {
        return {
          channelId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          channelId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check fetched notification channels')
      }
    },
    {
      name: 'Get notification channel',
      method: 'notification.channel.get',
      params: (context) => {
        return {
          channelId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          channelId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check gathered notification channel')
      }
    }
    ])
  }
}, module.parent)
