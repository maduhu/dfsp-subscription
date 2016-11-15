module.exports = {
  ports: [
    require('../db'),
    require('../httpserver'),
    require('../script')
  ],
  modules: {
    identity: require('../service/identity'),
    subscription: require('../service/subscription')
  },
  validations: {
    subscription: require('../service/subscription/api')
  }
}
