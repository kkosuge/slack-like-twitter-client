BrowserWindow = require 'browser-window'

module.exports =
class MainWindow
  constructor: ->
    window = new BrowserWindow
      width: 990,
      height: 700
    window.loadUrl("file://#{__dirname}/../index.html")

    window.on 'closed', =>
      window = null
