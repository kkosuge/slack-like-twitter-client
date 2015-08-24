$ = require 'jquery'
Profile = require './profile'
Tweets = require './tweets'
TweetBox = require './tweet_box'
React = require 'react'

$ ->
  React.render(
    <Profile />,
    document.getElementById('profile')
  )
  React.render(
    <Tweets />,
    document.getElementById('tweets')
  )
  React.render(
    <TweetBox />,
    document.getElementById('tweet-box')
  )
