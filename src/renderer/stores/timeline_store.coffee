EventEmitter = require('events').EventEmitter

class TimelineStore extends EventEmitter
  constructor: ->
    super()
    @tweetsTable = {}

  getTweets: =>
    tweets = Object.keys(@tweetsTable).map (key) => @tweetsTable[key]
    tweets.sort (a, b) => b.id - a.id

  mergeTweet: (tweet) =>
    @tweetsTable[tweet.id_str] = tweet
    @emit('changed')

  mergeTweets: (tweets) =>
    for tweet in tweets then @tweetsTable[tweet.id_str] = tweet
    @emit('changed')

global.timeline_store ||= new TimelineStore
module.exports = global.timeline_store
