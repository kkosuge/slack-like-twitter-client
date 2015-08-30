React = require 'react'

module.exports =
Profile = React.createClass
  render: ->
    <div className="user">
      <div className="profile-image">
        <img src={ @props.user.profile_image_url } />
      </div>
      <div className="screen-name">
        @{ @props.user.screen_name }
      </div>
    </div>
