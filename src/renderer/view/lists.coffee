TwitterClient = require '../twitter_client'
m = require 'mithril'

class ViewModel
  constructor: (account) ->
    @lists = m.prop([{ user: {} }])
    @client = new TwitterClient(account.credentails)
    @client.fetchLists()
      .then (lists) =>
        @lists(lists)
        m.redraw()

module.exports =
class Lists
  constructor: (account) ->
    @vm = new ViewModel(account)

  view: =>
    m "h3", "LIST"
    m ".channel-list", [
      m "ul", @vm.lists().map (list) =>
        m "li", [
          m "p", "@#{list.user.screen_name}/#{list.name}"
        ]
    ]
