import TimelineTweets from './timeline_tweets'
import TwitterClient from '../twitter_client'

export default class MentionTweets extends TimelineTweets {
  constructor(node) {
    super(node);
    this.client = new TwitterClient();
    this.update();
  }

  update() {
    (async () => {
       let tweets = await this.client.getMentions();
       info("MentionTweets#update")
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }
}
