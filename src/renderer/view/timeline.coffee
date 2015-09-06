TwitterClient = require '../twitter_client/twitter_client'
Helper = require '../helper/helper'
Tweet = require './tweet'
Timeline = require '../model/timeline'
twttr = require 'twitter-text'
m = require 'mithril'

class ViewModel
  windows: ->
    Timeline.windows()

  windowId: ->
    Timeline.windowId()

module.exports =
class TimelineView
  constructor: ->
    @vm = new ViewModel

  view: =>
    m "#tweets.tweets", Object.keys(@vm.windows()).map (windowId) =>
      m.component @vm.windows()[windowId], className: "tweet-box", key: "tweets-#{windowId}"
