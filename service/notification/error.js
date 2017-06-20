var create = require('ut-error').define
var Notification = create('notification')
var defaultErrorCode = 400

module.exports = {
  notification: function (cause) {
    return new Notification(cause)
  },
  error: [
    {
      type: 'notification',
      message: 'notification error'
    },
    {
      id: 'notificationChannelIdMissingError',
      type: 'notification.notificationChannelIdMissing',
      message: 'Missing notificationChannel id',
      statusCode: 422
    },
    {
      id: 'notificationOperationIdMissingError',
      type: 'notification.notificationOperationIdMissing',
      message: 'Missing notificationOperation id',
      statusCode: 422
    },
    {
      id: 'notificationTargetIdMissingError',
      type: 'notification.notificationTargetIdMissing',
      message: 'Missing notificationTarget id',
      statusCode: 422
    }
  ].reduce((exporting, error) => {
    var typePath = error.type.split('.')
    var Ctor = create(typePath.pop(), typePath.join('.'), error.message)
    /**
     * Exceptions thrown from the db procedures will not execute this function
     * It will only be executed if an error is throw from JS
     */
    exporting[error.type] = function (params) {
      return new Ctor({
        isJsError: true,
        params: params,
        statusCode: error.statusCode || defaultErrorCode,
        id: error.id || error.type
      })
    }
    return exporting
  }, {})
}