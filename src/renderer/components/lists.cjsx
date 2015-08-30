React = require 'react'
TimelineAction = require '../actions/timeline_actions'

module.exports =
Lists = React.createClass
  showList: (event) =>
    listName = event.target.getAttribute('data-list-name')
    listId = event.target.getAttribute('data-list-id')
    TimelineAction.showList
      name: listName
      id: listId

  render: ->
    lists = @props.lists.map (list) =>
      <div>
        <li>
          <a onClick={ @showList } key={ list.name } data-list-id={ list.id_str } data-list-name={ list.name }>{ list.name }</a>
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
