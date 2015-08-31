$ = require 'jquery'
Tweets = require './tweets'
Sidebar = require './sidebar'
TweetBox = require './tweet_box'
React = require 'react'
remote = require 'remote'
Twitter = remote.require 'node-twitter-api'
BrowserWindow = remote.require('browser-window')
Authentication = require '../authentication'
AccountStore = require '../stores/account_store'
ListStore = require '../stores/list_store'
TimelineStore = require '../stores/timeline_store'
TwitterClient = require '../twitter_client'
TimelineAction = require '../actions/timeline_actions'
ListAction = require '../actions/list_actions'
Container = require('flux/utils').Container

class Root extends React.Component
  @getStores: ->
    [AccountStore, TimelineStore, ListStore]

  @calculateState: (prevState, nextState) ->
    account: AccountStore.getAccount()
    tweets: TimelineStore.getTweets()
    lists: ListStore.getLists()

  componentDidMount: ->
    if AccountStore.userExists()
      document.getElementById('webview').remove()
      (new TimelineAction(@state.account.credentails)).fetch()
      #(new TimelineAction(@state.account.credentails)).userStream()
      (new ListAction(@state.account.credentails)).fetch()

  render: ->
    unless AccountStore.userExists()
      new Authentication
      return <div></div>

    <div className="container">
      <div className="side-menu">
        <Sidebar
          user={ @state.account.user }
          lists={ @state.lists }
        />
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
