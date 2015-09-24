import TimelineTweets from './timeline_tweets'
import HomeTimelineClient from '../twitter_client/home_timeline_client'

export default class HomeTweets extends TimelineTweets {
  constructor(node) {
    super(node);
    this.client = new HomeTimelineClient();
    this.update();
    this.runStream();
  }

  update() {
    (async () => {
       let tweets = await this.client.get();
       info("HomeTweets#update")
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }
}
