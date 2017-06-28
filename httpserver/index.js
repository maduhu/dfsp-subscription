var path = require('path')
module.exports = {
  id: 'httpserver',
  createPort: require('ut-port-httpserver'),
  logLevel: 'trace',
  api: ['subscription', 'notification'],
  imports: ['subscription.start'],
  port: 8017,
  allowXFF: true,
  disableXsrf: {
    http: true,
    ws: true
  },
  bundle: 'subscription',
  dist: path.resolve(__dirname, '../dist'),
  routes: {
    rpc: {
      method: '*',
      path: '/rpc/{method?}',
      config: {
        tags: ['rpc'],
        auth: false
      }
    }
  },
  start: function () {

  }
}
