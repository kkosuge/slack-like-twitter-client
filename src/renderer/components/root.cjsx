$ = require 'jquery'
Profile = require './profile'
Tweets = require './tweets'
TweetBox = require './tweet_box'
React = require 'react'
remote = require 'remote'
Twitter = remote.require 'node-twitter-api'
BrowserWindow = remote.require('browser-window')
Authentication = require '../authentication'
accountStore = require '../stores/account_store'
timelineStore = require '../stores/timeline_store'
TwitterClient = require '../twitter_client'

Root = React.createClass
  getInitialState: ->
    account: accountStore.getAccount()
    tweets: []

  componentWillMount: ->
    accountStore.on 'changed', (account) =>
      @setState(account: accountStore.getAccount().user)
    timelineStore.on 'changed', (tweets) =>
      @setState(tweets: timelineStore.getTweets())

  componentDidMount: ->
    if accountStore.userExists()
      document.getElementById('webview').remove()
      client = new TwitterClient(@state.account.credentails)
      client.fetchTimeline().then (tweets) =>
        timelineStore.mergeTweets(tweets)

  render: ->
    unless accountStore.userExists()
      new Authentication
      return <div></div>

    <div className="container">
      <div className="side-menu">
        <Profile user={ @state.account.user }/>
      </div>
      <div className="main-article">
        <Tweets tweets={ @state.tweets } />
        <TweetBox />
      </div>
    </div>

$ ->
  accountStore.ready().then (account) =>
    React.render(
      <Root />,
      document.getElementById('root')
    )
