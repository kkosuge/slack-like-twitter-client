$ = require 'jquery'
m = require 'mithril'
Profile = require './view/profile'
Timeline = require './view/timeline'
TweetBox = require './view/tweet_box'
Account = require './model/account'

$ ->
  @account = new Account
  @account.ready
    #.then =>
    #  @model.clear()
    .then =>
      @account.all()
    .then (accounts) =>
      account = accounts[0]
      account = if account? then account else {}

      document.getElementById("webview").remove()
      m.mount document.getElementById("profile"),
       view: (new Profile).view
      m.mount document.getElementById("tweets"),
       view: (new Timeline(account)).view
      m.mount document.getElementById("tweet-box"),
       view: (new TweetBox(account)).view
