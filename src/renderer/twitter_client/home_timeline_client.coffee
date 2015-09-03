remote = require 'remote'
Twitter = remote.require('twitter')
TwitterClient = require './twitter_client'

module.exports =
class HomeTimelineClient extends TwitterClient
  get: =>
    new Promise (resolve, reject) =>
      @client.get(
        'statuses/home_timeline',
        (error, tweets, response) => resolve(tweets))
