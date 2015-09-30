import TimelineTweets from './timeline_tweets'
import ListClient from '../twitter_client'

export default class ListTweets extends TimelineTweets {
  constructor(node, listId) {
    super(node);
    this.client = new ListClient();
    this.listId = listId;
    this.update();
  }

  update() {
    (async () => {
       let params = { listId: this.listId };
       let tweets = await this.client.getListTimeline(params);
       info(`ListTweets#update#${this.listId}`)
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }
}
