app = require 'app'
BrowserWindow = require 'browser-window'
Authentication = require './authentication'
Timeline = require './timeline'

global.twitter_credentials =
  consumer_key: 'b5vOZ3RqJMuOD3HAAuDWib6ZX',
  consumer_secret: '2HGGzCwXhxuuHfx56b4rBf5XWSWeRweLdAcVJKd6jCbObs5eiu',
  access_token_key: '290386705-rBklhwCuaGmxaAgwmPcExdIREVgjmGxrtjoj2woZ',
  access_token_secret: 'IDZYIfgcC8SX31ZURW07pP3LcCAQOFMh4Aq3Epga3aOUy'

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
      console.log credentials
      global.twitter_credentials.access_token_key = credentials.accessToken
      global.twitter_credentials.access_token_secret = credentials.accessTokenSecret
      @openMainWindow()
