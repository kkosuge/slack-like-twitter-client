Account = require '../model/account'
TwitterClient = require '../twitter_client/twitter_client'
Helper = require '../helper/helper'
Tweet = require './tweet'
twttr = require 'twitter-text'
m = require 'mithril'

class TweetModel
  constructor: ->
    @tweets = m.prop({})
    @className = m.prop('')

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
    ids = Object.keys(@tweets())
    keys = (ids.sort (a, b) => b - a).slice(0,100).reverse()
    keys.map (key) => @tweets()[key]

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
      @redraw()

  stream: =>
    @client.getTwitter().stream 'user', (stream) =>
      stream.on 'data', (data) =>
        if data.text
          @tweet.mergeTweet(data)
          @tweets(@tweet.get())
          @redraw()

  redraw: =>
    m.redraw()
    Helper.scrollToBottom()

module.exports =
class Tweets
  constructor: (client, params) ->
    @vm = new ViewModel(client, params)
    @windowId = m.prop(params.windowId)
    @currentWindowId = m.prop('')

  stream: =>
    @vm.stream()

  reload: =>
    @vm.reload()

  filter: (text) =>
    @vm.filter(text)

  tweets: =>
    if @vm.filter().length
      @vm.tweets().filter (tweet) => (new RegExp(@vm.filter())).test(tweet.text)
    else
      @vm.tweets()

  view: (ctrl, args) =>
    m "div", { class: args.className, 'data-window-id': @windowId() }, @tweets().map (tweet) =>
      m.component (new Tweet(tweet)), key: "#{@windowId()}-#{tweet.id}"
