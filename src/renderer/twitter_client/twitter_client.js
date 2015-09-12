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
}
