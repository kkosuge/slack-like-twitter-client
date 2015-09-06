e = require 'mithril'
Tweets = require '../view/tweets'
HomeTimelineClient = require '../twitter_client/home_timeline_client'
ListClient = require '../twitter_client/list_client'

class Timeline
  constructor: ->
    @windows = m.prop({})
    @title = m.prop('')
    @windowId = m.prop(null)
    @filterWord = m.prop('')

  stream: =>
    windowId = "home-timeline"
    windows = @windows()
    windows[windowId] ||= new Tweets(HomeTimelineClient, windowId: windowId)
    windows[windowId].stream()

  homeTimeline: =>
    @title("HOME TIMELINE")
    windowId = "home-timeline"
    windows = @windows()
    windows[windowId] ||= new Tweets(HomeTimelineClient, windowId: windowId)
    @selectWindow(windows, windowId)

  list: (list) =>
    @title("LIST @#{list.user.screen_name}/#{list.name}")
    windowId = "list-#{list.id_str}"
    windows = @windows()
    windows[windowId] ||= new Tweets(ListClient, windowId: windowId, listId: list.id_str)
    @selectWindow(windows, windowId)

  selectWindow: (windows, windowId) =>
    @windows(windows)
    @windowId(windowId)
    setTimeout Helper.scrollToBottom, 150
    boxes = document.getElementsByClassName('tweet-box')
    _.times boxes.length, (i) =>
      id = boxes[i].getAttribute('data-window-id')
      if @windowId() is id
        boxes[i].classList.remove('tweets-hide')
      else
        boxes[i].classList.add('tweets-hide')

  filter: (text) =>
    @filterWord(text)
    @currentWindow().filter(text)

  currentWindow: =>
    @windows()[@windowId()]

  setAutoRefresh: =>
    setInterval =>
      @currentWindow().reload()
    , 1000*45

  tweets: =>
    if @windowId()
      @currentWindow()
    else
      { view: (->) }

global._timeline ||= new Timeline
module.exports = global._timeline
