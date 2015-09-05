Timeline = require '../model/timeline'
TextchangeInput = require './textchange-input'
m = require 'mithril'

class ViewModel
  constructor: ->
    @title = m.prop(Timeline.title())
    @filter = m.prop(Timeline.filterWord())

  updateFilter: (text) =>
    @filter(text)
    Timeline.filter(text)

module.exports =
class Header
  constructor: ->
    @vm = new ViewModel()

  view: =>
    m "#header", [
      m "h1", @vm.title()
      m ".ui.icon.input", [
        m.component TextchangeInput, value: @vm.filter(), ontextchange: m.withAttr("value", @vm.updateFilter), type: "text", placeholder: "Search..."
        m "i.search.icon", ''
      ]
    ]
