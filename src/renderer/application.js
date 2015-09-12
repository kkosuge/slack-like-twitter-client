import m from 'mithril'
import Profile from './view/profile'
import Tweets from './view/tweets'
import TweetBox from './view/tweet_box'
import Lists from './view/lists'
import Header from './view/header'
import Main from './view/main'
import Timeline from './model/timeline'
import Account from './model/account'
import Authentication from './authentication'
import './helper/helper'

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

    m.mount(document.getElementById("profile"), {
     view: (new Profile).view
    });
    m.mount(document.getElementById("lists"), {
     view: (new Lists()).view
    });

    let main = new Main();
    main.getInitialTimeline();
    setTimeout( () => {
      m.mount(document.getElementById("main-article"), {
       view: main.view
      });
    }, 2000);
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
