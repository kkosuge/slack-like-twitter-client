remote = require 'remote'
Twitter = remote.require('twitter')

module.exports =
class TwitterClient
  constructor: (credentails) ->
    @client = new Twitter(global.accounts[0].credentails)

  getTwitter: => @client

  fetchAccount: =>
    new Promise (resolve, reject) =>
      @client.get(
        'account/verify_credentials',
        (error, account, response) => resolve(account))

  fetchTimeline: (screen_name) =>
    new Promise (resolve, reject) =>
      @client.get(
        'statuses/home_timeline',
        (error, tweets, response) => resolve(tweets))

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
