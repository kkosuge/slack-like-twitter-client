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
            <p>{ `@${list.user.screen_name}/${list.name}` }</p>
          </li>
        </div>
      );
    });

    return(
      <div>
        <h3>HOME</h3>
        <div className="channel-list">
          <ul>
            <li onClick={ this.showHomeTimeline }>
              <p>TIMELINE</p>
            </li>
          </ul>
        </div>
        <h3>LIST</h3>
        <div className="channel-list">
          <ul>
            { lists }
          </ul>
        </div>
      </div>
    );
  }
}
