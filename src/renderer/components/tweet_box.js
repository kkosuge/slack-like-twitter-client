import TwitterClient from '../twitter_client/twitter_client'

export default class TweetBox extends React.Component {
  constructor(props) {
    super(props);
    this.client = new TwitterClient();
    this.state = {
      text: ''
    };
  }

  componentDidMount() {
    autosize(React.findDOMNode(this.refs.textarea));
  }

  changeText(e) {
    let text = React.findDOMNode(this.refs.textarea).value
    this.setState({ text: text });
  }

  post() {
    (async () => {
      let text = React.findDOMNode(this.refs.textarea).value
      await this.client.postTweet(text)
      this.setState({ text: '' })
      React.findDOMNode(this.refs.textarea).value = ''
    })();
  }

  render() {
    return(
      <div className="tweet-form ui form">
        <textarea rows="1"
          ref="textarea"
          defaultValue={ this.state.text }
          onChange={ this.changeText.bind(this) }
        />
        <div className="tweet-panel">
          <button className="ui mini twitter button" onClick={ this.post.bind(this) }>POST</button>
        </div>
      </div>
    );
  }
}
