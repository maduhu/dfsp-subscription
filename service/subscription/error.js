var create = require('ut-error').define
var Subscription = create('subscription')

module.exports = {
  subscription: function (cause) {
    return new Subscription(cause)
  }
}
