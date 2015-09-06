Header = require './header'
Tweets = require './tweets'
TweetBox = require './tweet_box'
Timeline = require '../model/timeline'
TimelineView = require './timeline'
m = require 'mithril'

class ViewModel
  constructor: ->

module.exports =
class Main
  constructor: (account) ->
    @vm = new ViewModel()

  getInitialTimeline: =>
    Timeline.homeTimeline()
    Timeline.stream()
    Timeline.setAutoRefresh()

  view: =>
    [
      m.component (new Header), { key: 'header' }
      m.component (new TimelineView), { key: 'timeline' }
      m.component (new TweetBox), { key: 'tweet-box' }
    ]
