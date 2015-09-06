Account = require '../model/account'
TwitterClient = require '../twitter_client/twitter_client'
moment = require 'moment'
twttr = require 'twitter-text'
m = require 'mithril'

moment.locale 'en-short',
  relativeTime:
    d: "1d",
    dd: "%dd",
    future: "%s",
    h: "1h",
    hh: "%dh",
    m: "1m",
    M: "1M",
    mm: "%dm",
    MM: "%dM",
    past: "%s",
    s: "now",
    y: "1y",
    yy: "%dy"

class ViewModel
  constructor: (tweet) ->
    @tweet = m.prop(tweet)
    @body()

  createdAt: =>
    date = moment(new Date(@tweet().created_at))
    if date.isBefore(moment.duration(24, 'hours'))
      date.format('YYYY-MM-DD HH:mm')
    else
      date.locale('en-short').fromNow()

  media: =>
    images = []
    if @tweet().entities.media
      @tweet().entities.media.forEach (media) =>
        switch media.type
          when 'photo'
            images.push(m "img", { src: media.media_url_https })

    if images.length
      m ".media", images

  body: =>
    if @tweet().retweeted_status
      body = twttr.htmlEscape(@tweet().retweeted_status.text)
    else
      body = twttr.htmlEscape(@tweet().text)

    if @tweet().entities.urls.length
      @tweet().entities.urls.forEach (entity) =>
        body = body.replace entity.url,
        """<a onclick="Helper.openUrl('#{entity.url}')">#{entity.display_url}</a>"""

    if @tweet().entities.media
      @tweet().entities.media.forEach (media) =>
        body = body.replace media.url,
        """<a onclick="Helper.openUrl('#{media.url}')">#{media.display_url}</a>"""

    body

module.exports =
class Tweet
  constructor: (tweet) ->
    @vm = new ViewModel(tweet)

  controller: ->
    m.redraw.strategy("none")

  view: =>
    if @vm.tweet().retweeted_status
      m ".tweet.retweet", [
        m ".profile-image", [
          m "img", { src: Helper.largeIcon(@vm.tweet().retweeted_status.user) }
          m "img", { src: Helper.largeIcon(@vm.tweet().user), class: 'retweet-user'}
        ]
        m ".contents", [
          m ".name-contents", [
            m ".name", @vm.tweet().retweeted_status.user.name
            m ".screen-name", "@#{@vm.tweet().retweeted_status.user.screen_name}"
          ]
          m ".text", m.trust @vm.body()
          @vm.media()
        ]
      ]
    else
      m ".tweet", [
        m ".profile-image", [
          m "img", { src: Helper.largeIcon(@vm.tweet().user) }
        ]
        m ".contents", [
          m ".name-contents", [
            m ".name", @vm.tweet().user.name
            m ".screen-name", "@#{@vm.tweet().user.screen_name}"
            m "time.created-at", @vm.createdAt()
          ]
          m ".text", m.trust @vm.body()
          @vm.media()
        ]
      ]
