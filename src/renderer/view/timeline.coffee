Account = require '../model/account'
TwitterClient = require '../twitter_client'
m = require 'mithril'

class ViewModel
  constructor: (account) ->
    @tweets = m.prop([{ user: {} }])
    @client = new TwitterClient(account.credentails)
    @client.fetchTimeline(account.user.screen_name)
      .then (tweets) =>
        @tweets(tweets)
        m.redraw()

module.exports =
class Timeline
  constructor: (account) ->
    @vm = new ViewModel(account)

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
