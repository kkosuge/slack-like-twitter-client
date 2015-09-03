m = require 'mithril'
Tweets = require '../view/tweets'
HomeTimelineClient = require '../twitter_client/home_timeline_client'
ListClient = require '../twitter_client/list_client'

class Timeline
  homeTimeline: =>
    m.mount document.getElementById("tweets"),
     view: (new Tweets(HomeTimelineClient)).view

  list: (listId) =>
    m.mount document.getElementById("tweets"),
     view: (new Tweets(ListClient, listId)).view

global._timeline ||= new Timeline
module.exports = global._timeline
