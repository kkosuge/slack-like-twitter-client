remote = require 'remote'
Twitter = remote.require 'node-twitter-api'
accountStore = require './stores/account_store'
TwitterClient = require './twitter_client'

module.exports =
class Authentication
  constructor: ->
    @webview
    @consumerKey = remote.getGlobal('twitter_credentials').consumer_key
    @consumerSecret = remote.getGlobal('twitter_credentials').consumer_secret
    @requestToken = null
    @requestTokenSecret = null
    @accessToken = null
    @accessTokenSecret = null
    @twitter = new Twitter
      callback: 'http://twitter.com'
      consumerKey: @consumerKey
      consumerSecret: @consumerSecret
    @getRequestToken()

  watchRedirectRequest: ->
    @webview = document.getElementById("twitter-auth")
    @webview.addEventListener 'did-get-redirect-request', (event) =>
      url = event.newUrl
      if (matched = url.match(/\?oauth_token=([^&]*)&oauth_verifier=([^&]*)/))
        @getAccessToken(matched[2])

  getAccessToken: (oauth_verifier) =>
    @twitter.getAccessToken @requestToken, @requestTokenSecret, oauth_verifier, (error, accessToken, accessTokenSecret) =>
      @accessToken = accessToken
      @accessTokenSecret = accessTokenSecret
      @webview.remove()
      @updateAccount()
      #location.reload()

  getRequestToken: =>
    @twitter.getRequestToken (error, requestToken, requestTokenSecret) =>
      @requestToken = requestToken
      @requestTokenSecret = requestTokenSecret
      url = @twitter.getAuthUrl(requestToken)
      document.getElementById('webview').innerHTML =
        "<webview src='#{url}' id='twitter-auth'></webview>"
      @watchRedirectRequest()

  updateAccount: =>
    client = new TwitterClient
      consumer_key: @consumerKey
      consumer_secret: @consumerSecret
      access_token_key: @accessToken
      access_token_secret: @accessTokenSecret
    client.fetchAccount().then (user) =>
      accountStore.create user,
        consumer_key: @consumerKey
        consumer_secret: @consumerSecret
        access_token_key: @accessToken
        access_token_secret: @accessTokenSecret
