import TwitterClient from '../twitter_client/twitter_client'
import Timeline from '../timeline/timeline'

export default class Lists extends React.Component {
  constructor(props) {
    super(props);
    this.client = new TwitterClient();
    this.state = {
      lists: []
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
    Timeline.showList(list.id);
  }

  render() {
    let lists = this.state.lists.map((list) => {
      return(
        <div key={ `list-${list.id}` }>
          <li onClick={ this.showList.bind(this, list) }>
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
            <li className="active" onClick={ this.showHomeTimeline }>
              <i className="fa fa-home"></i> HOME TIMELINE
            </li>
            { lists }
          </ul>
        </div>
      </div>
    );
  }
}
