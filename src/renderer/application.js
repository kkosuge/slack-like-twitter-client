import './global/helper'
import './global/emitter'
import Timeline from './timeline/timeline'
import Account from './model/account'
import AccountComponent from './components/account'
import TweetBox from './components/tweet_box'
import Lists from './components/lists'
import Authentication from './authentication'

class Application {
  constructor() {
    let accounts;
    let account = new Account();

    (async () => {
      await account.ready;
      let accounts = await account.all();
      //await account.clear();

      if (accounts.length) {
        this.mount(accounts)
      } else {
        new Authentication();
      }
    })();
  }

  mount(accounts) {
    global.accounts = accounts;
    document.getElementById("webview").remove();

    React.render(<AccountComponent user={ accounts[0].user }/>, document.getElementById('profile'));
    React.render(<TweetBox user={ accounts[0].user }/>, document.getElementById('tweet-box'));
    React.render(<Lists />, document.getElementById('lists'));

    Timeline.showHomeTimeline();
  }
}

window.onload = () => {
  new Application();

  let ob = new MutationObserver( (mutations) => {
    Helper.scrollToBottom();
  });

  let config = { attributes: true, childList: true, characterData: true };
  ob.observe(document.getElementById('main-article'), config);
}
