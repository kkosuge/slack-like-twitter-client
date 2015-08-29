EventEmitter = require('events').EventEmitter
StoneSkin = require 'stone-skin/with-tv4'
TwitterClient = require '../twitter_client'

class Account extends StoneSkin.IndexedDb
  storeName: 'Account'
  schema:
    properties:
      user:
        type: 'object'
      credentials:
        type: 'object'

class AccountStore extends EventEmitter
  constructor: ->
    super()
    @model = new Account

  ready: =>
    @model.ready
      #.then =>
      #  @model.clear()
      .then =>
        @model.all()
      .then (accounts) =>
        account = accounts[0]
        @account = if account? then account else {}

  getAccount: => @account

  userExists: => !!Object.keys(@account).length

  create: (user, credentails) =>
    @account = {
      _id: user.id_str
      user: user
      credentails: credentails
    }
    @model.ready
      .then =>
        @model.save @account
        @emit('changed', @account)
      .then =>
        client = new TwitterClient(credentails)
        client.fetchTimeline().then (tweets) =>
          timelineStore.mergeTweets(tweets)


global.account_store ||= new AccountStore
module.exports = global.account_store
