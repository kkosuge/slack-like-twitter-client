import HomeTimelineClient from '../twitter_client/home_timeline_client'

export default class Timeline {
  constructor() {
    this.client = new HomeTimelineClient();
    this.template = Hogan.compile(this.template());
    this.node = this.initializeNode();
    this.getInitialTweets();
    this.runStream();
  }

  initializeNode() {
    let timeline = document.getElementById('tweets');
    let el = document.createElement("div");
    el.classList.add('tweets');
    timeline.appendChild(el);
    return el;
  }

  pushTweet(tweet) {
    let el = document.createElement("div");
    let images = [];
    let text = _.escape(tweet.retweeted_status ? tweet.retweeted_status.text : tweet.text);

    if (tweet.entities.media) {
      tweet.entities.media.forEach((media) => {
        if (media.type == 'photo') {
          images.push({
            html: `
              <a onclick="Helper.openUrl('${media.url}')">
                <img src="${media.media_url_https}" />
              </a>`
          });
        }

        text = text.replace(
          media.url,
          `<a onclick="Helper.openUrl('${media.url}')">${media.display_url}</a>`
        );
      });
    }

    if (tweet.entities.urls.length) {
      tweet.entities.urls.forEach((entity) => {
        text = text.replace(
          entity.url,
          `<a onclick="Helper.openUrl('${entity.url}')">${entity.display_url}</a>`
        );
      });
    }

    el.innerHTML = this.template.render({
      user: tweet.user,
      retweeted_user: (tweet.retweeted_status && tweet.retweeted_status.user),
      tweet: (tweet.retweeted_status ? tweet.retweeted_status : tweet),
      retweet: !!tweet.retweeted_status,
      text: text,
      includeMedia: !!images.length,
      images: images
    });
    this.node.appendChild(el);
  }

  template() {
    return `
      <div class="tweet {{#retweet}}retweet{{/retweet}}">
        <div class="profile-image">
          {{#retweet}}
            <img src="{{ retweeted_user.profile_image_url }}">
            <img src="{{ user.profile_image_url }}" class="retweet-user">
          {{/retweet}}
          {{^retweet}}
            <img src="{{ user.profile_image_url }}">
          {{/retweet}}
        </div>
        <div class="contents">
          <div class="name-contents">
            <div class="name">{{ user.name }}</div>
            <div class="screen-name">@{{ user.screen_name }}</div>
          </div>
          <div class="text">{{{ text }}}</div>
          {{#includeMedia}}
            <div class="media">
              {{#images}}
                {{{html}}}
              {{/images}}
            </div>
          {{/includeMedia}}
        </div>
      </div>
    `
  }

  getInitialTweets() {
    (async () => {
       let tweets = await this.client.get();
       tweets.reverse().forEach((tweet) => {
         this.pushTweet(tweet);
       });
    })();
  }

  runStream() {
    this.client.getTwitter().stream('user', (stream) => {
      stream.on('data', (data) => {
        if (data.text) {
          this.pushTweet(data)
        }
      });
    });
  }
}
