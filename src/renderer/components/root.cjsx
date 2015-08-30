$ = require 'jquery'
Profile = require './profile'
Lists = require './lists'
Tweets = require './tweets'
TweetBox = require './tweet_box'
React = require 'react'
remote = require 'remote'
Twitter = remote.require 'node-twitter-api'
BrowserWindow = remote.require('browser-window')
Authentication = require '../authentication'
AccountStore = require '../stores/account_store'
listStore = require '../stores/list_store'
TimelineStore = require '../stores/timeline_store'
TwitterClient = require '../twitter_client'
TimelineAction = require '../actions/timeline_actions'
Container = require('flux/utils').Container

class Root extends React.Component
  @getStores: ->
    [AccountStore, TimelineStore]

  @calculateState: (prevState, nextState) ->
    account: AccountStore.getAccount()
    tweets: TimelineStore.getTweets()

  componentDidMount: ->
    if AccountStore.userExists()
      document.getElementById('webview').remove()
      (new TimelineAction(@state.account.credentails)).fetch()
      (new TimelineAction(@state.account.credentails)).userStream()

  render: ->
    unless AccountStore.userExists()
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
  AccountStore.ready().then (account) =>
    RootContainer = Container.create(Root)
    React.render(
      <RootContainer />,
      document.getElementById('root')
    )
