remote = require 'remote'
EventEmitter = require('events').EventEmitter
Twitter = remote.require('twitter')
Dispatcher = require './dispatcher'

module.exports =
class TwitterClient
  constructor: (credentails) ->
    @client = new Twitter(credentails)

  fetchAccount: =>
    new Promise (resolve, reject) =>
      @client.get(
        'account/verify_credentials',
        (error, account, response) => resolve(account))

  fetchTimeline: (screen_name) =>
    new Promise (resolve, reject) =>
      @client.get(
        'statuses/home_timeline',
        { screen_name: screen_name },
        (error, tweets, response) => resolve(tweets))

  userStream: ->
    @client.stream(
      'user',
      (stream) =>
        stream.on 'data', (data) =>
          Dispatcher.dispatch
            type: 'user-stream'
            data: data)

  fetchLists: ->
    new Promise (resolve, reject) =>
      @client.get(
        'lists/list',
        (error, lists, response) => resolve(lists))

  fetchList: (listId) =>
    new Promise (resolve, reject) =>
      @client.get(
        'lists/statuses',
        { list_id: listId },
        (error, tweets, response) => resolve(tweets))
