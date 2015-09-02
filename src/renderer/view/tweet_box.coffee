Account = require '../model/account'
TwitterClient = require '../twitter_client'
m = require 'mithril'

class ViewModel
  constructor: (account) ->

module.exports =
class TweetBox
  constructor: (account) ->

  view: =>
    m ".tweet-form.ui.form", [
      m "textarea", { rows: 3 }
      m ".tweet-panel", [
        m "button", { class: "ui mini twitter button" }, "POST"
      ]
    ]
