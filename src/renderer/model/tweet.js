class Tweets {
  constructor() {
    this.tweets = {}
  }

  push(tweet) {
    this.tweets[tweet.id] = tweet;
  }

  find(statusId) {
    return this.tweets[statusId];
  }
}

export default new Tweets();
