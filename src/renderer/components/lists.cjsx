React = require 'react'

module.exports =
Lists = React.createClass
  render: ->
    lists = @props.lists.map (list) ->
      <div><li><a>{ list.name }</a></li></div>

    <div>
      <nav className="channel-list">
        <ul>
          { lists }
        </ul>
      </nav>
    </div>
