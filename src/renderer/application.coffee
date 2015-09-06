m = require 'mithril'
Profile = require './view/profile'
Tweets = require './view/tweets'
TweetBox = require './view/tweet_box'
Lists = require './view/lists'
Header = require './view/header'
Main = require './view/main'
Timeline = require './model/timeline'
Account = require './model/account'
Authentication = require './authentication'
require './helper/helper'

class Application
  constructor: ->
    @account = new Account
    @account.ready
      #.then =>
      #  @account.clear()
      .then =>
        @account.all()
      .then (accounts) =>
        unless accounts.length
          new Authentication
        else
          global.accounts = accounts
          document.getElementById("webview").remove()

          m.mount document.getElementById("profile"),
           view: (new Profile).view
          m.mount document.getElementById("lists"),
           view: (new Lists()).view

          main = new Main()
          main.getInitialTimeline()
          setTimeout ->
            m.mount document.getElementById("main-article"),
             view: main.view
          , 2000

window.onload = ->
  new Application

  ob = new MutationObserver (mutations) ->
    Helper.scrollToBottom()
  config = { attributes: true, childList: true, characterData: true }
  ob.observe(document.getElementById('main-article'), config)
