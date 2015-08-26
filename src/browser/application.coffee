app = require 'app'
BrowserWindow = require 'browser-window'
Authentication = require './authentication'
Timeline = require './timeline'

global.twitter_credentials =
  consumer_key: 'b5vOZ3RqJMuOD3HAAuDWib6ZX',
  consumer_secret: '2HGGzCwXhxuuHfx56b4rBf5XWSWeRweLdAcVJKd6jCbObs5eiu',

module.exports =
class Application
  constructor: ->
    global.application = @

    app.on 'window-all-closed', =>
      if (process.platform != 'darwin')
        app.quit()

    app.on 'ready', => @onReady()

    @accessToken = null
    @accessTokenSecret = null

  openMainWindow: =>
    new Timeline

  onReady: =>
    new Authentication (credentials) =>
      global.twitter_credentials.access_token_key = credentials.accessToken
      global.twitter_credentials.access_token_secret = credentials.accessTokenSecret
      @openMainWindow()
