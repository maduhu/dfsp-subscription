var test = require('ut-run/test')
var config = require('./../lib/appConfig')

const PHONE_NUMBER = '08994746666'
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
      name: 'Missing input params - Raise exception for missing actorr id',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {}
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'Missing actor id', error.errorPrint)
      }
    },
    {
      name: 'Missing input params - Raise exception for missing phone number',
      method: 'subscription.subscription.add',
      params: (context) => {
        return {
          actorId: ACTOR_ID
        }
      },
      error: (error, assert) => {
        assert.equal(error.errorPrint, 'Missing phone number', error.errorPrint)
      }
    },
    {
      name: 'Check returned results from subscription add',
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
    }
    ])
  }
}, module.parent)
