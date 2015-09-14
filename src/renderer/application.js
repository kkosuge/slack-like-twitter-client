import './helper/helper'
//import Profile from './view/profile'
//import Tweets from './view/tweets'
//import TweetBox from './view/tweet_box'
//import Lists from './view/lists'
//import Header from './view/header'
//import Main from './view/main'
import HomeTimeline from './timeline/home_timeline'
import Account from './model/account'
import AccountComponent from './components/account'
import TweetBox from './components/tweet_box'
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
    React.render(<TweetBox />, document.getElementById('tweet-box'));

    new HomeTimeline();
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
