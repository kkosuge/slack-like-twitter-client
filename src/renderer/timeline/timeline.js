import HomeTweets from './home_tweets'
import ListTweets from './list_tweets'

class Timeline {
  constructor() {
    this.tweets = {};
    this.windows = {};
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


  createElement(id) {
    let el = document.createElement("div");
    el.classList.add('tweets');
    el.setAttribute('data-timeline-id', id);
    document.getElementById('tweets').appendChild(el);
    return el;
  }

  switchTimeline(id) {
    let tweets = document.getElementsByClassName('tweets');
    Array.prototype.forEach.call(tweets, (node) =>{
      node.style.display = 'none';
    });
    let tl = document.querySelector(`div[data-timeline-id="${id}"]`);
    tl.style.display = '';
  }
}

export default new Timeline();
