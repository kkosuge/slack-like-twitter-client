$ = require 'jquery'
_ = require 'underscore'
React = require 'react'

Profile = React.createClass
  getInitialState: ->
    user: {}

  componentDidMount: ->
    twitter_client = new Twitter(
      require('remote').getGlobal('twitter_credentials')
    )

    twitter_client.get 'account/verify_credentials',  (error, status, response) =>
      @setState(user: status)


  render: ->
    <div className="user">
      <div className="profile-image">
        <img src={ this.state.user.profile_image_url } />
      </div>
      <div className="screen-name">
        @{ this.state.user.screen_name }
      </div>
    </div>

$ ->
  React.render(<Profile />, document.getElementById('profile'))
