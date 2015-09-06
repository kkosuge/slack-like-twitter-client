remote = require 'remote'
Twitter = remote.require('twitter')
TwitterClient = require './twitter_client'

module.exports =
class ListClient extends TwitterClient
  get: (params) =>
    new Promise (resolve, reject) =>
      @client.get(
        'lists/statuses',
        { list_id: params.listId },
        (error, tweets, response) => resolve(tweets))
