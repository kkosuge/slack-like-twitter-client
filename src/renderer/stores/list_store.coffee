EventEmitter = require('events').EventEmitter

class ListStore extends EventEmitter
  constructor: ->
    super()
    @listsTable = {}

  getLists: =>
    lists = Object.keys(@listsTable).map (key) => @listsTable[key]
    lists.sort (a, b) => b.name - a.name

  mergeList: (list) =>
    @listsTable[list.name] = tweet
    @emit('changed')

  mergeLists: (lists) =>
    for list in lists then @listsTable[list.name] = list
    @emit('changed')

global.list_store ||= new ListStore
module.exports = global.list_store
