module.exports = {
  id: 'script',
  createPort: require('ut-port-script'),
  imports: ['identity'],
  logLevel: 'trace',
  log: {
    transform: {
      payee: 'hide',
      name: 'hide',
      firstName: 'hide',
      lastName: 'hide',
      nationalId: 'hide',
      dob: 'hide'
    }
  }
}
