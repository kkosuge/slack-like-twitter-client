ReduceStore = require('flux/utils').ReduceStore
Dispatcher = require '../dispatcher'
Immutable = require 'immutable-store'

class ListStore extends ReduceStore
  getInitialState: ->
    Immutable
      lists: {}

  getLists: =>
    state = @getState()
    lists = Object.keys(state.lists).map (key) => state.lists[key]
    lists.sort (a, b) => b.name - a.name

  mergeLists: (state, lists) =>
    _lists = {}
    for list in lists
      _lists[list.name] = list
    state.lists.merge(_lists)

  reduce: (state, action) =>
    switch action.type
      when 'fetch-lists'
        @mergeLists(state, action.lists)
      else
        state

global.list_store ||= new ListStore(Dispatcher)
module.exports = global.list_store
