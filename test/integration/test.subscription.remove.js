var test = require('ut-run/test')
var config = require('./../lib/appConfig')

const PHONE_NUMBER = '01010101010'
const ACTOR_ID = '1111'
var subscriptionId

test({
  type: 'integration',
  name: 'Subscription',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Add subscription - subscription.remove',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {
          actorId: ACTOR_ID,
          phoneNumber: PHONE_NUMBER
        }
      },
      result: (result, assert) => {
        subscriptionId = result.subscriptionId
        assert.equal(result.actorId, ACTOR_ID, 'Check actorId result')
        assert.equal(result.phoneNumber, PHONE_NUMBER, 'Check phoneNumber result')
        assert.true((typeof result.subscriptionId === 'number'), 'Check subscriptionId result type')
      }
    },
    {
      name: 'Remove subscription',
      method: 'subscription.subscription.remove',
      params: (context) => {
        return {
          subscriptionId: subscriptionId
        }
      },
      result: (result, assert) => {}
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
        assert.true(result.length === 0, 'Check there is not a matching result')
      }
    }
    ])
  }
}, module.parent)
