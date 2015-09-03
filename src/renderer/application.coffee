$ = require 'jquery'
m = require 'mithril'
Profile = require './view/profile'
Timeline = require './view/timeline'
TweetBox = require './view/tweet_box'
Lists = require './view/lists'
Account = require './model/account'

$ ->
  @account = new Account
  @account.ready
    #.then =>
    #  @model.clear()
    .then =>
      @account.all()
    .then (accounts) =>
      global.accounts = accounts
      document.getElementById("webview").remove()

      m.mount document.getElementById("profile"),
       view: (new Profile).view
      m.mount document.getElementById("lists"),
       view: (new Lists()).view
      m.mount document.getElementById("tweets"),
       view: (new Timeline()).view
      m.mount document.getElementById("tweet-box"),
       view: (new TweetBox()).view
