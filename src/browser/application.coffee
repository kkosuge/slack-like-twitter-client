app = require 'app'
BrowserWindow = require 'browser-window'
MainWindow = require './main_window'

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

  onReady: =>
    new MainWindow
