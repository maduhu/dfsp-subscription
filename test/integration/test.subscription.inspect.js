var test = require('ut-run/test')
var config = require('./../lib/appConfig')
var joi = require('joi')
const request = require('supertest')('http://localhost:8017')
const SQLPASS = 'dfsppass'
const QUERY = 'SELECT * FROM notification.template'

test({
  type: 'integration',
  name: 'Subscription',
  server: config.server,
  serverConfig: config.serverConfig,
  client: config.client,
  clientConfig: config.clientConfig,
  steps: function (test, bus, run) {
    return run(test, bus, [{
      name: 'Pass incorrect password to the inspector',
      params: (context) => {
        return request
          .put('/inspect/wrongPass')
          .set('Content-Type', 'text/plain')
          .send(QUERY)
          .expect(200)
          .expect('Content-Type', 'text/html; charset=utf-8')
      },
      result: (result, assert) => {
        assert.equal(result.text, 'wrong password', 'Check that the password did not matched')
      }
    },
    {
      name: 'Pass SQL query',
      params: (context) => {
        return request
          .put('/inspect/' + SQLPASS)
          .set('Content-Type', 'text/plain')
          .send(QUERY)
          .expect(200)
          .expect('Content-Type', /json/)
      },
      result: (result, assert) => {
        assert.equals(joi.validate(result.body, joi.array().items({
          channelId: joi.number().required(),
          content: joi.string().required(),
          name: joi.string().required(),
          operationId: joi.number().required(),
          targetId: joi.number().required(),
          templateId: joi.number().required()
        }).required()).error, null, 'Check array schema from the returned query results')
      }
    }
    ])
  }
}, module.parent)
