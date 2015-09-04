TwitterClient = require '../twitter_client'
Timeline = require '../model/timeline'
m = require 'mithril'

class ViewModel
  constructor: () ->
    @lists = m.prop([{ user: {} }])
    @client = new TwitterClient()
    @client.fetchLists()
      .then (lists) =>
        @lists(lists)
        m.redraw()

  showList: (list) =>
    Timeline.list(list.id_str)

  showHomeTimeline: =>
    Timeline.homeTimeline()

module.exports =
class Lists
  constructor: ->
    @vm = new ViewModel()

  view: =>
    m "div", [
      m "h3", "HOME"
      m ".channel-list", [
        m "ul", [
          m "li", onclick: @vm.showHomeTimeline.bind(this), [
            m "p", "TIMELINE"
          ]
        ]
      ]
      m "h3", "LIST"
      m ".channel-list", [
        m "ul", @vm.lists().map (list) =>
          m "li", onclick: @vm.showList.bind(this, list), [
            m "p", "@#{list.user.screen_name}/#{list.name}"
          ]
      ]
    ]
