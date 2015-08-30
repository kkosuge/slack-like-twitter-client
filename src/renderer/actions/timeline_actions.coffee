TwitterClient = require '../twitter_client'
Dispatcher = require '../dispatcher'
AccountStore = require '../stores/account_store'

module.exports =
class TimelineAction
  constructor: (credentails) ->
    unless credentails
      credentails = AccountStore.getAccount().credentails

    @client = new TwitterClient(credentails)

  fetch: =>
    @client.fetchTimeline().then (tweets) =>
      Dispatcher.dispatch
        type: 'timeline',
        tweets: tweets

  userStream: =>
    @client.userStream()

  @showList: (list) =>
    Dispatcher.dispatch
      type: 'show-list',
      list:
        name: list.name
        id: list.id

  fetchList: (list) =>
    @client.fetchList(list.id).then (tweets) =>
      Dispatcher.dispatch
        type: 'list-tweets',
        name: list.name
        tweets: tweets
