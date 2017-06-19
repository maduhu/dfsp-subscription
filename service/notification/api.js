var joi = require('joi')
module.exports = {
  'notificationStatus.get': {
    // tags: ['tag1', 'tag2'],
    description: '',
    notes: '',
    auth: false,
    params: joi.any(),
    result: joi.any()
  }
}
