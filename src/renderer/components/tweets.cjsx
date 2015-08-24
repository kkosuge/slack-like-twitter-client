Twitter = require('remote').require('twitter')
React = require 'react'
Tweet = require './tweet'

module.exports =
Tweets = React.createClass
  getInitialState: ->
    tweets: []

  componentDidMount: ->
    klass = @

    twitter_client = new Twitter(
      require('remote').getGlobal('twitter_credentials')
    )

    twitter_client.get 'statuses/home_timeline', { screen_name: '9m' }, (error, tweets, response) ->
      if (!error)
        _tweets = klass.state.tweets
        [].push.apply(_tweets, tweets)
        klass.setState(tweets: _tweets)

    twitter_client.stream 'user', (stream) =>
      stream.on 'data', (data) =>
        console.log data.text
        if data.text
          _tweets = klass.state.tweets
          _tweets.push(data)
          klass.setState(tweets: _tweets)


  render: ->
    tweets =  @state.tweets.map (tweet) ->
      <Tweet tweet={ tweet } />

    <div className="tweets">
      { tweets }
    </div>
