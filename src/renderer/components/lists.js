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

  showMentions() {
    Timeline.showMentions();
  }

  render() {
    let currentWindowId = Timeline.currentWindowId;
    let homeClassName, mentionsClassName;
    let homeIsActive = currentWindowId === 'hometimeline';
    let mentionsIsActive = currentWindowId === 'mentions';
    let mentionsIsEnabled = !!this.state.windows['mentions'];

    if (homeIsActive) {
      homeClassName = 'active';
    } else {
      homeClassName = 'enabled';
    }

    if (mentionsIsActive) {
      mentionsClassName = 'active';
    } else if (mentionsIsEnabled) {
      mentionsClassName = 'enabled';
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
            { `${list.name}` }
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
            <li className={ mentionsClassName } onClick={ this.showMentions }>
              <i className="fa fa-at"></i> MENTIONS
            </li>
            { lists }
          </ul>
        </div>
      </div>
    );
  }
}
