$ = require 'jquery'
_ = require 'underscore'
remote = require 'remote'
Twitter = require('remote').require('twitter')
React = require 'react'

Tweet = React.createClass
  propTypes:
    tweet: React.PropTypes.object.isRequired

  render: ->
    <div className="tweet">
      <div className="profile-image">
        <img src={ this.props.tweet.user.profile_image_url } />
      </div>
      <div className="contents">
        <div className="name-contents">
          <div className="name">
            { this.props.tweet.user.name }
          </div>
          <div className="screen-name">
            { this.props.tweet.user.screen_name }
          </div>
        </div>
        <div className="text">
          { this.props.tweet.text }
        </div>
      </div>
    </div>


Tweets = React.createClass
  getInitialState: () ->
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

    <div>
      { tweets }
    </div>

$ ->
  React.render(<Tweets />, document.getElementById('tweets'))
