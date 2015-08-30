remote = require 'remote'
EventEmitter = require('events').EventEmitter
Twitter = remote.require('twitter')

module.exports =
class TwitterClient
  constructor: (credentails) ->
    @client = new Twitter(credentails)

  fetchAccount: =>
    new Promise (resolve, reject) =>
      @client.get(
        'account/verify_credentials',
        (error, account, response) => resolve(account)
      )

  fetchTimeline: (screen_name) =>
    new Promise (resolve, reject) =>
      @client.get(
        'statuses/home_timeline',
        { screen_name: screen_name },
        (error, tweets, response) => resolve(tweets)
      )

  fetchLists: ->
    new Promise (resolve, reject) =>
      @client.get(
        'lists/list',
        (error, lists, response) => resolve(lists)
      )

