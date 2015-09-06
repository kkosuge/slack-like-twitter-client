shell = require('shell')

window.$ = require 'jquery'
window.m = require 'mithril'
window._ = require 'underscore'
window.Velocity = require 'velocity'
window.pp = (object) -> console.log JSON.stringify(object, null, 2)

module.exports = window.Helper =
  largeIcon: (user) =>
    user.profile_image_url.replace('_normal','_reasonably_small')

  openUrl: (url) =>
    shell.openExternal(url)

  scrollToBottom: =>
    el = document.getElementById('tweets')
    if el?
      $(el).scrollTop(el.scrollHeight)
    else
      setTimeout(@scrollToBottom, 100)


