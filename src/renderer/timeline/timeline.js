import HomeTweets from './home_tweets'
import ListTweets from './list_tweets'
import MentionTweets from './mention_tweets'
import FavoriteTweets from './favorite_tweets'

class Timeline {
  constructor() {
    this.tweets = {};
    this.windows = {};
    this.currentWindowName = "HOME TIMELINE";
    this.currentWindowId = '';
    this.updateIntervalId = setInterval(this.updateAll.bind(this), 1000*60*2);
    this.gcIntervalId = setInterval(this.gcAll.bind(this), 1000*60*15);
  }

  updateAll() {
    let windowIds = Object.keys(this.windows);
    windowIds.forEach((windowId) => {
      let window = this.windows[windowId];
      window.update();
    });
  }

  gcAll() {
    let windowIds = Object.keys(this.windows);
    windowIds.forEach((windowId) => {
      let window = this.windows[windowId];
      window.gc();
    });
  }

  showHomeTimeline() {
    let id = "hometimeline";

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new HomeTweets(el);
    }

    this.currentWindowName = "HOME TIMELINE";
    this.switchTimeline(id);
  }

  showList(list) {
    let id = `list-${list.id_str}`;

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new ListTweets(el, list.id_str);
    }

    this.currentWindowName = `${list.user.screen_name} / ${list.name}`;
    this.switchTimeline(id);
  }

  showMentions() {
    let id = "mentions";

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new MentionTweets(el);
    }

    this.currentWindowName = "MENTIONS";
    this.switchTimeline(id);
  }

  showFavorites() {
    let id = "favorites";

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new FavoriteTweets(el);
    }

    this.currentWindowName = "FAVORITES";
    this.switchTimeline(id);
  }


  currentWindow() {
    return this.windows[this.currentWindowId];
  }

  createElement(id) {
    let el = document.createElement("div");
    el.classList.add('tweets');
    el.setAttribute('data-timeline-id', id);
    document.getElementById('tweets').appendChild(el);
    return el;
  }

  switchTimeline(id) {
    let nextWindow = this.windows[id];
    let el = document.getElementById('tweets');

    if (this.currentWindow()) {
      this.currentWindow().scrollTop = el.scrollTop;
      this.currentWindow().scrollBottom = el.scrollHeight - el.scrollTop;
    }

    let tweets = document.getElementsByClassName('tweets');
    Array.prototype.forEach.call(tweets, (node) =>{
      node.style.display = 'none';
    });

    let tl = document.querySelector(`div[data-timeline-id="${id}"]`);
    tl.style.display = '';

    if (nextWindow.scrollTop) {
      el.scrollTop = el.scrollHeight - nextWindow.scrollBottom;
    } else if (nextWindow.scrollTop === 0) {
      el.scrollTop = 0;
    } else {
      el.scrollTop = el.scrollHeight;
    }

    this.currentWindowId = id;
    emitter.emit('refresh');
  }
}

export default new Timeline();
