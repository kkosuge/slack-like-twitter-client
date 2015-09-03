remote = require 'remote'
Twitter = remote.require('twitter')

module.exports =
class TwitterClient
  constructor: (credentails) ->
    unless credentails
      credentails = global.accounts[0].credentails
    @client = new Twitter(credentails)

  getTwitter: => @client

  postTweet: (text) =>
    new Promise (resolve, reject) =>
      @client.post 'statuses/update', { status: text }, (error, tweet, response) => resolve(response)

  fetchAccount: =>
    new Promise (resolve, reject) =>
      @client.get 'account/verify_credentials', (error, account, response) => resolve(account)

  fetchLists: ->
    new Promise (resolve, reject) =>
      @client.get 'lists/list', (error, lists, response) => resolve(lists)
