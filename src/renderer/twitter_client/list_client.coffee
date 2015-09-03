remote = require 'remote'
Twitter = remote.require('twitter')
TwitterClient = require './twitter_client'

module.exports =
class ListClient extends TwitterClient
  get: (listId) =>
    new Promise (resolve, reject) =>
      @client.get(
        'lists/statuses',
        { list_id: listId },
        (error, tweets, response) => resolve(tweets))
