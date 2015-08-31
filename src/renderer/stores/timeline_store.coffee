ReduceStore = require('flux/utils').ReduceStore
Dispatcher = require '../dispatcher'
Immutable = require 'immutable-store'
TimelineAction = require '../actions/timeline_actions'
AccountStore = require '../stores/account_store'

class TimelineStore extends ReduceStore
  getInitialState: ->
    Immutable
      currentType: 'home-timeline'
      tweets: {}

  getTweets: =>
    state = @getState()
    console.log Object.keys(state.tweets)
    console.log state.currentType
    if state.tweets[state.currentType]
      tweets = Object.keys(state.tweets[state.currentType]).map (key) => state.tweets[state.currentType][key]
      tweets.sort (a, b) => b.id - a.id
    else
      []

  mergeTweet: (state, type, tweet) =>
    state.tweets.set(tweet.id_str, tweet)

  mergeTweets: (state, type, tweets) ->
    _tweets = {}
    _tweets[type] ||= {}
    for tweet in tweets
      _tweets[type][tweet.id_str] = tweet
    state.tweets.merge(_tweets)

  showList: (state, list) ->
    (new TimelineAction).fetchList(list)
    state.set('currentType', list.name)

  reduce: (state, action) =>
    switch action.type
      when 'timeline'
        @mergeTweets(state, 'home-timeline', action.tweets)
      when 'user-stream'
        if action.data.created_at
          @mergeTweet(state, 'home-timeline', action.data)
        else
          state
      when 'show-list'
        @showList(state, action.list)
      when 'list-tweets'
        @mergeTweets(state, action.name, action.tweets)
      else
        state

global.timeline_store ||= new TimelineStore(Dispatcher)
module.exports = global.timeline_store
