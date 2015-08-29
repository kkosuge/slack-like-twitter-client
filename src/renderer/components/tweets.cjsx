Twitter = require('remote').require('twitter')
React = require 'react'
Tweet = require './tweet'

module.exports =
Tweets = React.createClass
  render: ->
    tweets = @props.tweets.map (tweet) ->
      <Tweet tweet={ tweet } />

    <div id="tweets">
      <div className="tweets">
        { tweets }
      </div>
    </div>
