import HomeTweets from './home_tweets'
import ListTweets from './list_tweets'

class Timeline {
  constructor() {
    this.tweets = {};
    this.windows = {};
    this.currentWindowId = '';
    this.updateIntervalId = setInterval(this.updateAll.bind(this), 1000*60);
  }

  updateAll() {
    let windowIds = Object.keys(this.windows);
    windowIds.forEach((windowId) => {
      let window = this.windows[windowId];
      window.update();
    });
  }

  showHomeTimeline() {
    let id = "hometimeline";

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new HomeTweets(el);
    }

    this.switchTimeline(id);
  }

  showList(listId) {
    let id = `list-${listId}`;

    if (!this.windows[id]) {
      let el = this.createElement(id);
      this.windows[id] = new ListTweets(el, listId);
    }

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
    }

    let tweets = document.getElementsByClassName('tweets');
    Array.prototype.forEach.call(tweets, (node) =>{
      node.style.display = 'none';
    });

    let tl = document.querySelector(`div[data-timeline-id="${id}"]`);
    tl.style.display = '';

    if (nextWindow.scrollTop) {
      el.scrollTop = nextWindow.scrollTop;
    } else {
      el.scrollTop = el.scrollHeight;
    }
    this.currentWindowId = id;
  }
}

export default new Timeline();
