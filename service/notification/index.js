var path = require('path')
require('./error')

var interpolatePattern = /\$\{([^}]*)\}/g

var interpolate = function (message, params) {
  return message.replace(interpolatePattern, (placeHolder, label) => (params[label]))
}

module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }],
  // channelId, operationId, targetId, actorId, destinations, params
  'add.execute': function (msg) {
    return this.super['notification.template.get']({
      channelId: msg.channelId,
      operationId: msg.operationId,
      targetId: msg.targetId
    })
    .then((template) => {
      msg.content = interpolate(template.content, msg.params)
      msg.templateId = template.templateId
      return this.super['notification.notification.add'](msg)
    })
  }
}
