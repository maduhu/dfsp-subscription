var test = require('ut-run/test')
var config = require('./../lib/appConfig')
var joi = require('joi')

const PHONE_NUMBER = '111111111'
const ACTOR_ID = '1'

test({
  type: 'integration',
  name: 'Subscription',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Add subscription - subscription.get',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          phoneNumber: PHONE_NUMBER
        }
      },
      result: (result, assert) => {
        assert.equal(result.actorId, ACTOR_ID, 'Check actorId result')
        assert.equal(result.phoneNumber, PHONE_NUMBER, 'Check phoneNumber result')
        assert.true((typeof result.subscriptionId === 'number'), 'Check subscriptionId result type')
      }
    },
    {
      name: 'Get subscription - phoneNumber',
      method: 'subscription.subscription.get',
      params: (context) => {
        return {
          phoneNumber: PHONE_NUMBER
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          actorId: joi.string().required(),
          phoneNumber: joi.string().required(),
          primary: joi.boolean().required(),
          isSingleResult: joi.boolean()
        }).required()).error, null, 'Check array schema from the returned results - phone number')
      }
    },
    {
      name: 'Get subscription - actor id',
      method: 'subscription.subscription.get',
      params: (context) => {
        return {
          actorId: ACTOR_ID
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          actorId: joi.string().required(),
          phoneNumber: joi.string().required(),
          primary: joi.boolean().required(),
          isSingleResult: joi.boolean()
        }).required()).error, null, 'Check array schema from the returned results - phone number')
      }
    }
    ])
  }
}, module.parent)
