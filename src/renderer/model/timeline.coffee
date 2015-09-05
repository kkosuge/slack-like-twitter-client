m = require 'mithril'
Tweets = require '../view/tweets'
HomeTimelineClient = require '../twitter_client/home_timeline_client'
ListClient = require '../twitter_client/list_client'

class Timeline
  constructor: ->
    @windows = m.prop({})

  stream: =>
    windowId = "home-timeline"
    windows = @windows()
    windows[windowId] ||= new Tweets(HomeTimelineClient)
    windows[windowId].stream()

  homeTimeline: =>
    windowId = "home-timeline"
    windows = @windows()
    windows[windowId] ||= new Tweets(HomeTimelineClient)
    @windows(windows)
    @mount(windowId)

  list: (listId) =>
    windowId = "list-#{listId}"
    windows = @windows()
    windows[windowId] ||= new Tweets(ListClient, listId)
    @windows(windows)
    @mount(windowId)

  mount: (windowId) =>
    m.mount document.getElementById("tweets"),
      view: @windows()[windowId].view

global._timeline ||= new Timeline
module.exports = global._timeline
