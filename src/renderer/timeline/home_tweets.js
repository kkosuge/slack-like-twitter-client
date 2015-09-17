import Tweets from './tweets'
import HomeTimelineClient from '../twitter_client/home_timeline_client'

export default class HomeTweets extends Tweets {
  constructor(node) {
    super(node);
    this.client = new HomeTimelineClient();
    this.update();
    this.runStream();
    this.intervalId = setInterval(this.update, 1000*60);
  }
}
