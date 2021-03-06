shell = require('shell')
require 'babel/polyfill'
window.$ = require 'jquery'
window.m = require 'mithril'
window._ = require 'lodash'
window.autosize = require 'autosize'
#window.Velocity = require 'velocity'
window.pp = (object) -> console.log JSON.stringify(object, null, 2)
window.React = require 'react'
window.Hogan = require 'hogan.js'

window.info = (title, any) ->
  time = (new Date).toLocaleString()
  console.log("#{time}: #{title}")
  if typeof any is 'undefined'
    return
  if typeof any is 'object'
    console.log JSON.stringify(object, null, 2)
  else
    console.log any

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

  findElementFromPathByClass: (path, className) =>
    element = path.find (el) =>
      if el.classList.length
        return el.classList.contains(className)
      else
        return false
    return element

$(document).on 'click', 'a', ->
  if /^https?/.test(this.href)
    Helper.openUrl(this.href)
    return false
