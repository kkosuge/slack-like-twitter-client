import TwitterClient from '../twitter_client/twitter_client'
import Timeline from '../timeline/timeline'

export default class Lists extends React.Component {
  constructor(props) {
    super(props);

    this.client = new TwitterClient();
    this.state = {
      lists: [],
      windows: this.props.windows
    };
  }

  componentDidMount() {
    (async () => {
      let lists = await this.client.fetchLists();
      this.setState({lists: lists});
    })();
  }

  showHomeTimeline() {
    Timeline.showHomeTimeline();
  }

  showList(list) {
    Timeline.showList(list);
  }

  render() {
    let currentWindowId = Timeline.currentWindowId;
    let homeClassName;
    let homeIsActive = currentWindowId === 'hometimeline';

    if (homeIsActive) {
      homeClassName = 'active';
    } else {
      homeClassName = 'enabled';
    }

    let lists = this.state.lists.map((list) => {
      let className;
      let id = `list-${list.id}`;
      let enabled = !!this.state.windows[id];
      let active = (id === currentWindowId);

      if (active) {
        className = 'active';
      } else if (enabled) {
        className = 'enabled';
      }

      return(
        <div key={ `list-${list.id}` }>
          <li
            onClick={ this.showList.bind(this, list) }
            className={ className }
          >
            <i className="fa fa-list"></i>
            { `${list.user.screen_name}/${list.name}` }
          </li>
        </div>
      );
    });

    return(
      <div>
        <div className="channel-list">
          <ul>
            <li className={ homeClassName } onClick={ this.showHomeTimeline }>
              <i className="fa fa-home"></i> HOME TIMELINE
            </li>
            { lists }
          </ul>
        </div>
      </div>
    );
  }
}
