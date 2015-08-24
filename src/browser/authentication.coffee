BrowserWindow = require 'browser-window'
Twitter = require 'node-twitter-api'

module.exports =
class Authentication
  constructor: (callback) ->
    klass = @
    twitter = new Twitter
      callback: 'http://example.com',
      consumerKey: global.twitter_credentials.consumer_key,
      consumerSecret: global.twitter_credentials.consumer_secret

    twitter.getRequestToken (error, requestToken, requestTokenSecret) =>
      url = twitter.getAuthUrl(requestToken)
      this.window = new BrowserWindow({ width: 800, height: 600 })
      this.window.webContents.on 'will-navigate', (event, url) =>
        if (matched = url.match(/\?oauth_token=([^&]*)&oauth_verifier=([^&]*)/))
          twitter.getAccessToken requestToken, requestTokenSecret, matched[2], (error, accessToken, accessTokenSecret) =>
            callback
              accessToken: accessToken,
              accessTokenSecret: accessTokenSecret
        event.preventDefault()
        klass.window.close()

      this.window.loadUrl(url)
