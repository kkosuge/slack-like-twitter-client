Twitter = require('remote').require('twitter')
React = require 'react'

module.exports =
Tweet = React.createClass
  propTypes:
    tweet: React.PropTypes.object.isRequired

  render: ->
    <div className="tweet">
      <div className="profile-image">
        <img src={ this.props.tweet.user.profile_image_url } />
      </div>
      <div className="contents">
        <div className="name-contents">
          <div className="name">
            { this.props.tweet.user.name }
          </div>
          <div className="screen-name">
            { this.props.tweet.user.screen_name }
          </div>
        </div>
        <div className="text">
          { this.props.tweet.text }
        </div>
      </div>
    </div>



