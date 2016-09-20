var path = require('path')
// var error = require('./error')
module.exports = {
  schema: [{
    path: path.join(__dirname, 'schema'),
    linkSP: true
  }]
}
