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

  mergeTweet: (state, tweet) =>
    state.tweets.set(tweet.id_str, tweet)

  mergeTweets: (state, tweets) ->
    _tweets = {}
    for tweet in tweets
      _tweets[tweet.id_str] = tweet
    state.tweets.merge(_tweets)

  reduce: (state, action) =>
    switch action.type
      when 'timeline'
        @mergeTweets(state, action.tweets)
      when 'user-stream'
        if action.data.created_at
          @mergeTweet(state, action.data)
        else
          state
      else
        state

global.timeline_store ||= new TimelineStore(Dispatcher)
module.exports = global.timeline_store
