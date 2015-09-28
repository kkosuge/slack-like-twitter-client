import Account from './account'
import TweetBox from './tweet_box'
import Lists from './lists'
import ArticleHeader from './article_header'
import Timeline from '../timeline/timeline'

export default class Root extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      windowName: Timeline.currentWindowName,
      windows: Timeline.windows
    };

    emitter.on('refresh', () => {
      this.setState({
        windowName: Timeline.currentWindowName,
        windows: Timeline.windows
      });
    });
  }

  render() {
    return(
      <div className="container">
        <div className="side-menu">
          <div id="title-bar"></div>
          <Account user={ this.props.user }/>
          <Lists windows={ this.state.windows } />
        </div>
        <div id="main-article">
          <div id="tweets"></div>
          <ArticleHeader windowName={ this.state.windowName } />
          <TweetBox user={ this.props.user } />
        </div>
      </div>
    );
  }
}
