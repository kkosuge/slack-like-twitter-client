Account = require '../model/account'
TwitterClient = require '../twitter_client/twitter_client'
Helper = require '../helper/helper'
Tweet = require './tweet'
twttr = require 'twitter-text'
m = require 'mithril'

class TweetModel
  constructor: ->
    @tweets = m.prop({})

  mergeTweets: (tweets) =>
    _tweets = @tweets()
    for tweet in tweets
      _tweets[tweet.id_str] = tweet
    @tweets(_tweets)

  mergeTweet: (tweet) =>
    _tweets = @tweets()
    _tweets[tweet.id_str] = tweet
    @tweets(_tweets)

  get: =>
    tweets = Object.keys(@tweets()).map (key) => @tweets()[key]
    tweets.sort (a, b) => b.id - a.id

class ViewModel
  constructor: (client, params) ->
    @tweet  = new TweetModel
    @client = new client
    @tweets = m.prop([])

    @client.get(params).then (tweets) =>
      @tweet.mergeTweets(tweets)
      @tweets(@tweet.get())
      m.redraw()

   # @client.getTwitter().stream 'user', (stream) =>
   #   stream.on 'data', (data) =>
   #     console.log data
   #     if data.created_at
   #       @tweet.mergeTweet(data)
   #       @tweets(@tweet.get())
   #       m.redraw()

module.exports =
class Tweets
  constructor: (client, params) ->
    @vm = new ViewModel(client, params)

  view: =>
    m ".tweets", @vm.tweets().map (tweet) =>
      m.component (new Tweet(tweet)), { key: tweet.id }
