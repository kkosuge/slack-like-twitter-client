TwitterClient = require '../twitter_client/twitter_client'
m = require 'mithril'

class ViewModel
  constructor: ->
    @text = m.prop('')

  tweet: =>
    client = new TwitterClient
    client.postTweet(@text()).then (response) => @text('')


module.exports =
class TweetBox
  constructor: ->
    @vm = new ViewModel

  view: =>
    m "#tweet-box.tweet-form.ui.form", [
      m "textarea", rows: 3, onchange: m.withAttr("value", @vm.text), value: @vm.text()
      m ".tweet-panel", [
        m "button", { onclick: @vm.tweet,  class: "ui mini twitter button" }, "POST"
      ]
    ]
