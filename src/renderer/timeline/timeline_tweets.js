import Tweet from '../model/tweet'
window.Tweet = Tweet;
import TwitterClient from '../twitter_client/twitter_client'

export default class TimelineTweets {
  constructor(node) {
    this.node = node;
    this.template = Hogan.compile(this.template());
    this.statusIds = [];
    this.scrollTop = 0;
    this.autoScroll = false;
    this.client = new TwitterClient();
  }

  pushTweet(tweet) {
    if (_.includes(this.statusIds, tweet.id)) {
      return false;
    }

    Tweet.push(tweet);

    let el = document.createElement("div");
    let images = [];
    let text = _.escape(tweet.retweeted_status ? tweet.retweeted_status.text : tweet.text);

    if (tweet.entities.media) {
      tweet.entities.media.forEach((media) => {
        if (media.type == 'photo') {
          images.push({
            html: `<img src="${media.media_url_https}" />`
          });
        }

        text = text.replace(
          media.url,
          `<a href="${media.url}" target="_blank">${media.display_url}</a>`
        );
      });
    }

    if (tweet.entities.urls.length) {
      tweet.entities.urls.forEach((entity) => {
        text = text.replace(
          entity.url,
          `<a href="${entity.url}" target="_blank">${entity.display_url}</a>`
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
      images: images,
      created_at: this.isoTime(tweet.created_at),
      statusUrl: `https://twitter.com/${tweet.user.screen_name}/status/${tweet.id_str}`
    });

    //el.querySelector('.js-add-favorite').addEventListener('click', this.toggleFavorite.bind(this))

    let tweets = document.getElementById('tweets');
    let prevScrollMinusTop = tweets.scrollHeight - tweets.scrollTop;

    el.style.opacity = 0;
    let firstChild = this.node.firstChild;
    this.node.insertBefore(el, firstChild);
    Velocity(el, { opacity: 1 }, { duration: 600 });

    if (tweets.scrollTop > 0) {
      tweets.scrollTop = tweets.scrollHeight - prevScrollMinusTop;
    }

    this.statusIds.push(tweet.id);
  }

  toggleFavorite(e) {
    let el = Helper.findElementFromPathByClass(e.path, 'favorite');
    let tweetEl = Helper.findElementFromPathByClass(e.path, 'tweet');
    let statusId = tweetEl.dataset.statusId

    if (el.classList.contains("favorited")) {
      el.classList.remove('favorited');
      this.client.unfavorite(statusId);
    } else {
      el.classList.add('favorited');
      this.client.favorite(statusId);
    }

    return false;
  }

  isoTime(timeText) {
    let date = new Date(timeText);
    return date.toISOString();
  }

  template() {
    return `
      <div class="tweet {{#retweet}}retweet{{/retweet}}" data-status-id="{{ tweet.id_str }}">
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
          <div class="contents-header">
            <div class="name">{{ user.name }}</div>
            <div class="screen-name">
              <i class="fa fa-at"></i><b>{{ user.screen_name }}</b>
            </div>
            <div class="created-at">
              <a href="{{ statusUrl }}" target="_blank">
                <time is="relative-time" datetime="{{ created_at }}"></time>
              </a>
            </div>
          </div>

          <div class="text">{{{ text }}}</div>

          {{#includeMedia}}
            <div class="media">
              {{#images}}
                {{{html}}}
              {{/images}}
            </div>
          {{/includeMedia}}

          <div class="contents-footer">
            <div class="action reply">
              <i class="fa fa-reply"></i>
            </div>
            <div class="action retweet">
              <i class="fa fa-retweet"></i>
            </div>
            <div class="action favorite js-add-favorite{{#tweet.favorited}} favorited{{/tweet.favorited}}">
              <i class="fa fa-star"></i>
            </div>
            <div class="source">
              {{{ tweet.source }}}
            </div>
          </div>
        </div>

      </div>
    `
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
