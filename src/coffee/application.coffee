app = require 'app'
crashReporter = require 'crash-reporter'
BrowserWindow = require 'browser-window'
AuthenticationWindow = require './authentication_window'
MainWindow = require './main_window'

global.twitter_credentials =
  consumer_key: 'b5vOZ3RqJMuOD3HAAuDWib6ZX',
  consumer_secret: '2HGGzCwXhxuuHfx56b4rBf5XWSWeRweLdAcVJKd6jCbObs5eiu',

module.exports =
class Application
  constructor: ->
    @accessToken = null
    @accessTokenSecret = null
    @mainWindow = null
    @windows = []
    @startCrashReporter()
    @registerApplicationCallbacks()

  startCrashReporter: ->
    crashReporter.start()

  openMainWindow: =>
    new MainWindow

  registerApplicationCallbacks: =>
    klass = @
    app.on 'window-all-closed', =>
      if (process.platform != 'darwin')
        app.quit()

    app.on 'ready', =>
      new AuthenticationWindow (credentials) =>
        console.log credentials
        global.twitter_credentials.access_token_key = credentials.accessToken
        global.twitter_credentials.access_token_secret = credentials.accessTokenSecret
        @openMainWindow()
