import Account from './model/account'
import Application from './application'
import remote from 'remote'
const TwitterClient = require('./twitter_client/twitter_client');
const Twitter = remote.require('node-twitter-api');

export default class Authentication {
  constructor() {
    this.webview;
    this.consumerKey = remote.getGlobal('twitter_credentials').consumer_key;
    this.consumerSecret = remote.getGlobal('twitter_credentials').consumer_secret;
    this.requestToken = null;
    this.requestTokenSecret = null;
    this.accessToken = null;
    this.accessTokenSecret = null;
    this.twitter = new Twitter({
      callback: 'http://twitter.com',
      consumerKey: this.consumerKey,
      consumerSecret: this.consumerSecret
    });
    this.getRequestToken();
  }

  watchRedirectRequest() {
    this.webview = document.getElementById("twitter-auth");
    this.webview.addEventListener('did-get-redirect-request', (event) => {
      let url = event.newUrl;
      let matched = url.match(/\?oauth_token=([^&]*)&oauth_verifier=([^&]*)/)
      if (matched) {
        this.getAccessToken(matched[2]);
      }
    });
  }

  getAccessToken(oauth_verifier) {
    this.twitter.getAccessToken(
        this.requestToken,
        this.requestTokenSecret,
        oauth_verifier,
        (error, accessToken, accessTokenSecret) => {
          this.accessToken = accessToken;
          this.accessTokenSecret = accessTokenSecret;
          this.webview.remove();
          this.updateAccount();
        }
    );
  }

  getRequestToken() {
    this.twitter.getRequestToken( (error, requestToken, requestTokenSecret) => {
      this.requestToken = requestToken;
      this.requestTokenSecret = requestTokenSecret;
      let url = this.twitter.getAuthUrl(requestToken);
      document.getElementById('webview').innerHTML =
        `<webview src="${url}" id='twitter-auth' nodeintegration></webview>`;
      this.watchRedirectRequest();
    });
  }

  updateAccount() {
    let credentails = {
      consumer_key: this.consumerKey,
      consumer_secret: this.consumerSecret,
      access_token_key: this.accessToken,
      access_token_secret: this.accessTokenSecret
    };

    (async () => {
      let client = new TwitterClient(credentails);
      let user = await client.fetchAccount();
      let account = new Account();
      await account.ready;
      await account.save({
        _id: user.id_str,
        user: user,
        credentails: credentails
      });
      document.getElementById('webview').remove();
      location.reload();
    })();
  }
}
