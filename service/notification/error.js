var create = require('ut-error').define
var defaultErrorCode = 400

module.exports = {
  error: [
    {
      type: 'notification',
      message: 'notification error'
    },
    {
      id: 'notificationTemplateIdMissingError',
      type: 'notification.templateIdMissing',
      message: 'Missing templateId',
      statusCode: 422
    },
    {
      id: 'notificationChannelIdMissingError',
      type: 'notification.channelIdMissing',
      message: 'Missing channelId',
      statusCode: 422
    },
    {
      id: 'notificationOperationIdMissingError',
      type: 'notification.operationIdMissing',
      message: 'Missing operationId',
      statusCode: 422
    },
    {
      id: 'notificationTargetIdMissingError',
      type: 'notification.targetIdMissing',
      message: 'Missing targetId',
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
        statusCode: error.statusCode, // || defaultErrorCode, // removed due to code coverage increasing - use when there are errors without statusCode
        id: error.id // || error.type // removed due to code coverage increasing - use when there are errors without id
      })
    }
    return exporting
  }, {})
}
