React = require 'react'
Profile = require './profile'
Lists = require './lists'

module.exports =
Sidebar = React.createClass
  render: ->
    <div>
      <Profile user={ @props.user }/>
      <h3>TIMELINE</h3>
      <nav className="channel-list">
        <ul>
          <li><p>HOME</p></li>
        </ul>
      </nav>
      <Lists lists={ @props.lists } />
    </div>
