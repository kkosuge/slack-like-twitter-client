import remote from 'remote'
const Twitter = require('twitter');

export default class TwitterClient {
  constructor(credentails) {
    if (!credentails) {
      credentails = global.accounts[0].credentails;
    }
    this.client = new Twitter(credentails);
  }

  getTwitter() {
   return this.client;
  }

  getHomeTimeline() {
    return new Promise((resolve, reject) => {
      this.client.get(
        'statuses/home_timeline',
        { count: 50 },
        (error, tweets, response) => {
          resolve(tweets);
        }
      )
    });
  }

  getListTimeline(params) {
    return new Promise((resolve, reject) => {
      this.client.get(
        'lists/statuses',
        { list_id: params.listId },
        (error, tweets, response) => {
          resolve(tweets)
        }
      )
    });
  }

  getMentions() {
    return new Promise((resolve, reject) => {
      this.client.get(
        'statuses/mentions_timeline',
        { count: 50 },
        (error, tweets, response) => {
          resolve(tweets);
        }
      )
    });
  }

  getFavorites() {
    return new Promise((resolve, reject) => {
      this.client.get(
        'favorites/list',
        { count: 50 },
        (error, tweets, response) => {
          resolve(tweets);
        }
      )
    });
  }

  postTweet(text) {
    return new Promise((resolve, reject) => {
      this.client.post(
        'statuses/update',
        { status: text },
        (error, tweet, response) => {
          resolve(response)
        }
      )
    });
  }

  fetchAccount() {
    return new Promise( (resolve, reject) => {
      this.client.get(
        'account/verify_credentials',
        (error, account, response) => {
          resolve(account)
        }
      )
    });
  }

  fetchLists() {
    return new Promise((resolve, reject) => {
      this.client.get(
        'lists/list',
        (error, lists, response) => {
          resolve(lists);
        }
      )
    });
  }

  favorite(statusId) {
    console.log(statusId);
    return new Promise((resolve, reject) => {
      this.client.post(
        'favorites/create',
        { id: statusId },
        (error, tweet, response) => {
          resolve({ response: response, tweet: tweet });
        }
      );
    });
  }

  unfavorite(statusId) {
    return new Promise((resolve, reject) => {
      this.client.post(
        'favorites/destroy',
        { id: statusId },
        (error, tweet, response) => {
          resolve({ response: response, tweet: tweet });
        }
      );
    });
  }
}
