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
    @params = params
    @filter = m.prop('')
    @reload()

  reload: =>
    @client.get(@params).then (tweets) =>
      @tweet.mergeTweets(tweets)
      @tweets(@tweet.get())
      m.redraw()

  stream: =>
    @client.getTwitter().stream 'user', (stream) =>
      stream.on 'data', (data) =>
        if data.text
          @tweet.mergeTweet(data)
          @tweets(@tweet.get())
          m.redraw()

module.exports =
class Tweets
  constructor: (client, params) ->
    @vm = new ViewModel(client, params)

  stream: =>
    @vm.stream()

  reload: =>
    @vm.reload()

  filter: (text) =>
    @vm.filter(text)
    m.redraw()

  tweets: =>
    if @vm.filter().length
      @vm.tweets().filter (tweet) => (new RegExp(@vm.filter())).test(tweet.text)
    else
      @vm.tweets()

  view: =>
    m "#tweets.tweets", @tweets().map (tweet) =>
      m.component (new Tweet(tweet)), { key: tweet.id }
