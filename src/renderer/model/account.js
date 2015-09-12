import StoneSkin from 'stone-skin/with-tv4'

export default class Account extends StoneSkin.IndexedDb {
  storeName: 'Account';
  schema: {
    properties: {
      user: {
        type: 'object'
      },
      credentials: {
        type: 'object'
      }
    }
  }
}
