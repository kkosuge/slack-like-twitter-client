BrowserWindow = require 'browser-window'

module.exports =
class Timeline
  constructor: ->
    window = new BrowserWindow
      width: 800,
      height: 600
    window.loadUrl("file://#{__dirname}/../index.html")

    window.on 'closed', =>
      window = null
