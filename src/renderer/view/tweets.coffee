Account = require '../model/account'
TwitterClient = require '../twitter_client'
m = require 'mithril'

class Tweet
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
    @tweet  = new Tweet
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
    m ".tweets", @vm.tweets().map (tweet) ->
      m ".tweet", [
        m ".profile-image", [
          m "img", { src: tweet.user.profile_image_url }
        ]
        m ".contents", [
          m ".name-contentes", [
            m ".name", tweet.user.name
            m ".screen-name", tweet.user.screen_name
          ]
          m ".text", tweet.text
        ]
    ]
