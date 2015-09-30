import TimelineTweets from './timeline_tweets'
import TwitterClient from '../twitter_client/twitter_client'

export default class FavoriteTweets extends TimelineTweets {
  constructor(node) {
    super(node);
    this.client = new TwitterClient();
    this.update();
  }

  update() {
    (async () => {
       let tweets = await this.client.getFavorites();
       info("FavoriteTweets#update")
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }
}
