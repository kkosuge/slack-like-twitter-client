React = require 'react'
TimelineAction = require '../actions/timeline_actions'

module.exports =
Lists = React.createClass
  showList: (listId, listName) =>
    TimelineAction.showList
      name: listName
      id: listId

  render: ->
    lists = @props.lists.map (list) =>
      <div>
        <li onClick={ @showList.bind(this, list.id_str, list.name) } key={ list.id_str }>
          <p>@{ list.user.screen_name }/{ list.name }</p>
        </li>
      </div>

    <div>
      <h3>LISTS</h3>
      <nav className="channel-list">
        <ul>
          { lists }
        </ul>
      </nav>
    </div>
