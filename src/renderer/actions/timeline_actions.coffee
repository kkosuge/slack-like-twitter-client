TwitterClient = require '../twitter_client'
Dispatcher = require '../dispatcher'

module.exports =
class TimelineAction
  @fetch: (credentails) ->
    client = new TwitterClient(credentails)
    client.fetchTimeline().then (tweets) =>
      Dispatcher.dispatch
        type: 'timeline',
        tweets: tweets
