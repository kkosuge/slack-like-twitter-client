console.log 1212
$ = require 'jquery'
Profile = require './profile'
Tweets = require './tweets'
TweetBox = require './tweet_box'
React = require 'react'

Root = React.createClass
  render: ->
    <div className="container">
      <div className="side-menu">
        <Profile />
      </div>
      <div className="main-article">
        <Tweets />
        <TweetBox />
      </div>
    </div>

$ ->
  React.render(
    <Root />,
    document.body
  )
