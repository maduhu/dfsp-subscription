var test = require('ut-run/test')
var config = require('./../lib/appConfig')
var joi = require('joi')

const PHONE_NUMBERS = ['111111111', '2222222222']
const ACTOR_IDS = ['1', '2']

test({
  type: 'integration',
  name: 'Subscription',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Add subscription - #1',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {
          actorId: ACTOR_IDS[0],
          phoneNumber: PHONE_NUMBERS[0]
        }
      },
      result: (result, assert) => {
        assert.equal(result.actorId, ACTOR_IDS[0], 'Check actorId result - #1')
        assert.equal(result.phoneNumber, PHONE_NUMBERS[0], 'Check phoneNumber result - #1')
        assert.true((typeof result.subscriptionId === 'number'), 'Check subscriptionId result type - #1')
      }
    },
    {
      name: 'Add subscription - #2',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {
          actorId: ACTOR_IDS[1],
          phoneNumber: PHONE_NUMBERS[1]
        }
      },
      result: (result, assert) => {
        assert.equal(result.actorId, ACTOR_IDS[1], 'Check actorId result - #2')
        assert.equal(result.phoneNumber, PHONE_NUMBERS[1], 'Check phoneNumber result - #2')
        assert.true((typeof result.subscriptionId === 'number'), 'Check subscriptionId result type - #2')
      }
    },
    {
      name: 'Missing input params',
      method: 'subscription.subscription.fetch',
      params: (context) => {
        return {}
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          actorId: joi.string().required(),
          phoneNumber: joi.string().required(),
          primary: joi.boolean().required()
        }).required()).error, null, 'Check array schema from the returned results - missing input')
      }
    },
    {
      name: 'Fetch subscriptions - actorId',
      method: 'subscription.subscription.fetch',
      params: (context) => {
        return {
          actorId: ACTOR_IDS[1]
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          actorId: joi.string().required(),
          phoneNumber: joi.string().required(),
          primary: joi.boolean().required()
        }).required()).error, null, 'Check array schema from the returned results - actorId')
      }
    },
    {
      name: 'Fetch subscriptions - phoneNumber',
      method: 'subscription.subscription.fetch',
      params: (context) => {
        return {
          phoneNumber: PHONE_NUMBERS[1]
        }
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result, joi.array().items({
          actorId: joi.string().required(),
          phoneNumber: joi.string().required(),
          primary: joi.boolean().required()
        }).required()).error, null, 'Check array schema from the returned results - phone number')
      }
    }
    ])
  }
}, module.parent)
