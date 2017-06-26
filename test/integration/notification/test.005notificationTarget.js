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
      method: 'notification.target.fetch',
      params: (context) => {
        return {
          targetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          targetId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check fetched notification targets')
      }
    },
    {
      name: 'Get notification status',
      method: 'notification.target.get',
      params: (context) => {
        return {
          targetId: 1
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.object().keys({
          targetId: joi.number(),
          name: joi.string(),
          description: joi.string()
        }).required()).error, null, 'Check gathered notification target')
      }
    }
    ])
  }
}, module.parent)
