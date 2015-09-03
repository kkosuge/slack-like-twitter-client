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

  show: (list) ->
    Timeline.list(list.id_str)

module.exports =
class Lists
  constructor: ->
    @vm = new ViewModel()

  view: =>
    m "h3", "LIST"
    m ".channel-list", [
      m "ul", @vm.lists().map (list) =>
        m "li", onclick: @vm.show.bind(this, list), [
          m "p", "@#{list.user.screen_name}/#{list.name}"
        ]
    ]
