import TwitterClient from './twitter_client'

export default class ListClient extends TwitterClient {
  get(params) {
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
}
