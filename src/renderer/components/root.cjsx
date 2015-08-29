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

Root = React.createClass
  getInitialState: ->
    account: accountStore.getAccount().user

  componentDidMount: ->
    accountStore.on 'changed', (account) =>
      @setState(account: account.user)

  render: ->
    unless accountStore.userExists()
      new Authentication
      return <div></div>

    <div className="container">
      <div className="side-menu">
        <Profile user={ @state.account }/>
      </div>
      <div className="main-article">
        <Tweets />
        <TweetBox />
      </div>
    </div>

$ ->
  accountStore.ready().then (account) =>
    React.render(
      <Root />,
      document.getElementById('root')
    )
