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
    return new Promise (resolve, reject) =>
      @client.get(
        'statuses/home_timeline',
        { screen_name: screen_name },
        (error, tweets, response) => resolve(tweets)
      )
