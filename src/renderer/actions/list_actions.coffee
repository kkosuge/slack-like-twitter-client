TwitterClient = require '../twitter_client'
Dispatcher = require '../dispatcher'

module.exports =
class ListAction
  constructor: (credentails) ->
    @client = new TwitterClient(credentails)

  fetch: =>
    @client.fetchLists().then (lists) =>
      Dispatcher.dispatch
        type: 'fetch-lists',
        lists: lists
