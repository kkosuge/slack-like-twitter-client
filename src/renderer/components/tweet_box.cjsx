$ = require 'jquery'
_ = require 'underscore'
React = require 'react'

module.exports =
TweetBox = React.createClass
  getInitialState: () ->
    text: ''

  handleButtonClick: ->
    text = @state.text
    twitter_client = new Twitter(
      require('remote').getGlobal('twitter_credentials')
    )
    twitter_client.post 'statuses/update', { status: text },  (error, tweet, response) ->
      throw error if error
      console.log(tweet)
      console.log(response)

  handleTextareaChange: (e) ->
    @setState(text: e.target.value)

  render: ->
    <div id="tweet-box">
      <div className="tweet-form ui form">
        <textarea rows="3" value={ this.state.text } onChange={ this.handleTextareaChange }></textarea>
        <div className="tweet-panel">
          <button className="ui mini twitter button" onClick={ this.handleButtonClick }>POST</button>
        </div>
      </div>
    </div>
