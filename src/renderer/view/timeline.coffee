Account = require '../model/account'
TwitterClient = require '../twitter_client'
m = require 'mithril'

class ViewModel
  constructor: () ->
    @tweets = m.prop([{ user: {} }])
    @client = new TwitterClient()
    @client.fetchTimeline()
      .then (tweets) =>
        @tweets(tweets)
        m.redraw()

module.exports =
class Timeline
  constructor: () ->
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
