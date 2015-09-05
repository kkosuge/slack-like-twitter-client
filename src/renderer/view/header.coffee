Timeline = require '../model/timeline'
m = require 'mithril'

class ViewModel
  constructor: ->
    @title = m.prop(Timeline.title())

module.exports =
class Lists
  constructor: ->
    @vm = new ViewModel()

  view: =>
    m "#header", [
      m "h1", @vm.title()
      m ".ui.icon.input", [
        m "input", { type: "text", placeholder: "Search..." }
        m "i.search.icon", ''
      ]
    ]
