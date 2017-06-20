var path = require('path')
var joi = require('joi')
var db = null
// var error = require('./error')

var interpolatePattern = /\{([^}]*)\}/g

var interpolate = function (message, params) {
  return message.replace(interpolatePattern, (placeHolder, label) => (params[label]))
}

module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  start: function () {
    if (this.config.db) {
      db = this
    }
    this.registerRequestHandler && this.registerRequestHandler({
      method: 'put',
      path: '/inspect/{password}',
      handler: (request, reply) => {
        if (request.params.password === db.config.db.password) {
          return db.exec({
            query: request.payload,
            process: 'json'
          })
          .then(result => reply(result.dataSet))
          .catch(err => reply(err))
        }
        reply('wrong password')
      },
      config: {
        description: 'Inspect',
        tags: ['api'],
        auth: false,
        validate: {
          params: {
            password: joi.string().required()
          },
          payload: joi.string().required()
        },
        plugins: {
          'hapi-swagger': {
            consumes: ['text/plain']
          }
        }
      }
    })
  },
  // notificationChannelId, notificationOperationId, notificationTargetId, destination, params
  'notification.notification.add': function (msg) {
    this.super['notification.notificationTemplate.get']({
      notificationChannelId: msg.notificationChannelId,
      notificationOperationId: msg.notificationOperationId,
      notificationTargetId: msg.notificationTargetId
    })
    .then((template) => {
      msg.content = interpolate(template.content, msg.params)
      msg.notificationTemplateId = template.notificationTemplateId
      return this.super['notification.notification.add'](msg)
    })
  }
}
