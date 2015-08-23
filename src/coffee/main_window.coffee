BrowserWindow = require 'browser-window'

module.exports =
class MainWindow
  constructor: ->
    @window = new BrowserWindow
      width: 800,
      height: 600
    @window.loadUrl("file://#{__dirname}/../html/index.html")

    @window.on 'closed', =>
      @window = null
