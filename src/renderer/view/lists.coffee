TwitterClient = require '../twitter_client'
m = require 'mithril'

class ViewModel
  constructor: () ->
    @lists = m.prop([{ user: {} }])
    @client = new TwitterClient()
    @client.fetchLists()
      .then (lists) =>
        @lists(lists)
        m.redraw()

module.exports =
class Lists
  constructor: ->
    @vm = new ViewModel()

  view: =>
    m "h3", "LIST"
    m ".channel-list", [
      m "ul", @vm.lists().map (list) =>
        m "li", [
          m "p", "@#{list.user.screen_name}/#{list.name}"
        ]
    ]
