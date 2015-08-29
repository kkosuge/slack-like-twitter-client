$ = require 'jquery'
Profile = require './profile'
Tweets = require './tweets'
TweetBox = require './tweet_box'
React = require 'react'
remote = require 'remote'
Twitter = remote.require 'node-twitter-api'
BrowserWindow = remote.require('browser-window')
Authentication = require '../authentication'

Root = React.createClass
  getAccount: ->
    localStorage.account

  render: ->
    unless @getAccount()
      new Authentication
      return <div></div>

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
    document.getElementById('root')
  )
