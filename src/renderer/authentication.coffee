remote = require 'remote'
Twitter = remote.require 'node-twitter-api'

module.exports =
class Authentication
  constructor: ->
    @webview
    @requestToken = null
    @requestTokenSecret = null
    @twitter = new Twitter
      callback: 'http://twitter.com',
      consumerKey: remote.getGlobal('twitter_credentials').consumer_key,
      consumerSecret: remote.getGlobal('twitter_credentials').consumer_secret
    @getRequestToken()

  watchRedirectRequest: ->
    @webview = document.getElementById("twitter-auth")
    @webview.addEventListener 'did-get-redirect-request', (event) =>
      url = event.newUrl
      if (matched = url.match(/\?oauth_token=([^&]*)&oauth_verifier=([^&]*)/))
        @getAccessToken(matched[2])

  getAccessToken: (oauth_verifier) =>
    @twitter.getAccessToken @requestToken, @requestTokenSecret, oauth_verifier, (error, accessToken, accessTokenSecret) =>
      localStorage.account = true
      console.log localStorage.account
      account = {
        accessToken: accessToken,
        accessTokenSecret: accessTokenSecret
      }
      @webview.remove()
      location.reload()

  getRequestToken: =>
    @twitter.getRequestToken (error, requestToken, requestTokenSecret) =>
      @requestToken = requestToken
      @requestTokenSecret = requestTokenSecret
      url = @twitter.getAuthUrl(requestToken)
      document.body.innerHTML =
        "<webview src='#{url}' id='twitter-auth'></webview>"
      @watchRedirectRequest()
