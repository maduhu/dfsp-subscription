module.exports = {
  ports: [
    require('../db'),
    require('../httpserver'),
    require('../script')
  ],
  modules: {
    identity: require('../service/identity'),
    subscription: require('../service/subscription'),
    notification: require('../service/notification')
  },
  validations: {
    subscription: require('../service/subscription/api'),
    notification: require('../service/notification/api')
  }
}
