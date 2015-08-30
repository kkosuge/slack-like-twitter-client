ReduceStore = require('flux/utils').ReduceStore
StoneSkin = require 'stone-skin/with-tv4'
TwitterClient = require '../twitter_client'
Dispatcher = require '../dispatcher'
Immutable = require 'immutable-store'
TimelineAction = require '../actions/timeline_actions'

class Account extends StoneSkin.IndexedDb
  storeName: 'Account'
  schema:
    properties:
      user:
        type: 'object'
      credentials:
        type: 'object'

class AccountStore extends ReduceStore
  constructor: (args) ->
    super(args)
    @model = new Account

  getInitialState: ->

  reduce: (state, action) =>
    null

  addListener: ->

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
      .then =>
        TimelineAction.fetch(credentails)
        document.getElementById('webview').remove()

global.account_store ||= new AccountStore(Dispatcher)
module.exports = global.account_store
