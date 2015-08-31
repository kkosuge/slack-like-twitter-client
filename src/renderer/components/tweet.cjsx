Twitter = require('remote').require('twitter')
React = require 'react'

module.exports =
Tweet = React.createClass
  profileImageUrl: ->
    this.props.tweet.user.profile_image_url.replace('_normal', '_reasonably_small')

  propTypes:
    tweet: React.PropTypes.object.isRequired

  render: ->
    <div className="tweet">
      <div className="profile-image">
        <img src={ @profileImageUrl() } />
      </div>
      <div className="contents">
        <div className="name-contents">
          <div className="name">
            { @props.tweet.user.name }
          </div>
          <div className="screen-name">
            { @props.tweet.user.screen_name }
          </div>
        </div>
        <div className="text">
          { @props.tweet.text }
        </div>
      </div>
    </div>



