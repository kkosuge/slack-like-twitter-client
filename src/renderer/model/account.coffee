StoneSkin = require 'stone-skin/with-tv4'

module.exports =
class Account extends StoneSkin.IndexedDb
  storeName: 'Account'
  schema:
    properties:
      user:
        type: 'object'
      credentials:
        type: 'object'
