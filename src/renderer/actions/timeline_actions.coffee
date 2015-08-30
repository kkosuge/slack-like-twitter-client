TwitterClient = require '../twitter_client'
Dispatcher = require '../dispatcher'

module.exports =
class TimelineAction
  constructor: (credentails) ->
    @client = new TwitterClient(credentails)

  fetch: =>
    @client.fetchTimeline().then (tweets) =>
      Dispatcher.dispatch
        type: 'timeline',
        tweets: tweets

  userStream: =>
    @client.userStream()
