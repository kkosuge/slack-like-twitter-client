import TwitterClient from './twitter_client'

export default class HomeTimelineClient extends TwitterClient {
  get() {
    return new Promise((resolve, reject) => {
      this.client.get(
        'statuses/home_timeline',
        { count: 200 },
        (error, tweets, response) => {
          resolve(tweets);
        }
      )
    });
  }
}
