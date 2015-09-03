Account = require '../model/account'
TwitterClient = require '../twitter_client'
m = require 'mithril'

class Tweets
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
  constructor: ->
    @tweets_model = new Tweets
    @client = new TwitterClient

    @tweets = m.prop([])

    @client.fetchTimeline().then (tweets) =>
      @tweets_model.mergeTweets(tweets)
      @tweets(@tweets_model.get())
      m.redraw()

    @client.getTwitter().stream 'user', (stream) =>
      stream.on 'data', (data) =>
        if data.created_at
          @tweets_model.mergeTweet(data)
          @tweets(@tweets_model.get())
          m.redraw()

module.exports =
class Timeline
  constructor: ->
    @vm = new ViewModel()

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
