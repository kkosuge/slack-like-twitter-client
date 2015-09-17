import ListClient from '../twitter_client/list_client'
import Tweets from './tweets'

export default class ListTweets extends Tweets {
  constructor(node, listId) {
    super(node);
    this.client = new ListClient();
    this.listId = listId;
    this.update();
    this.intervalId = setInterval(this.update, 1000*60);
  }

  update() {
    (async () => {
       let params = { listId: this.listId };
       let tweets = await this.client.get(params);
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }
}