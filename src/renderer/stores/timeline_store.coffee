ReduceStore = require('flux/utils').ReduceStore
Dispatcher = require '../dispatcher'
Immutable = require 'immutable-store'

class TimelineStore extends ReduceStore
  getInitialState: ->
    Immutable
      tweets: {}

  getTweets: =>
    state = @getState()
    tweets = Object.keys(state.tweets).map (key) => state.tweets[key]
    tweets.sort (a, b) => b.id - a.id

  mergeTweet: (tweet) =>
    state.tweets.set(tweet.id_str, tweet)

  mergeTweets: (state, tweets) ->
    _tweets = {}
    for tweet in tweets
      _tweets[tweet.id_str] = tweet
    state.tweets.merge(_tweets)

  reduce: (state, action) =>
    if action.type is 'timeline'
      @mergeTweets(state, action.tweets)
    else
      state

global.timeline_store ||= new TimelineStore(Dispatcher)
module.exports = global.timeline_store
