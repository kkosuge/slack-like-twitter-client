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
    let textEl = React.findDOMNode(this.refs.textarea);
    let panelEl = React.findDOMNode(this.refs.tweetPanel);

    autosize(textEl);
    textEl.addEventListener('focus', () => {
      panelEl.style.display = 'block';
    });
    textEl.addEventListener('blur', () => {
      setTimeout(() => {
        panelEl.style.display = 'none';
      }, 200);
    });
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
        <div className="account">
          <img src={ this.props.user.profile_image_url } />
        </div>
        <div className="form-box">
          <textarea rows="1"
            ref="textarea"
            defaultValue={ this.state.text }
            onChange={ this.changeText.bind(this) }
            placeholder="What's happening?"
          />
          <div
            className="tweet-panel"
            ref="tweetPanel"
          >
            <button className="ui mini twitter button" onClick={ this.post.bind(this) }>POST</button>
          </div>
        </div>
      </div>
    );
  }
}
