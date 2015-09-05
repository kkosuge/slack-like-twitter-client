Account = require '../model/account'
TwitterClient = require '../twitter_client/twitter_client'
twttr = require 'twitter-text'
m = require 'mithril'

class ViewModel
  constructor: (tweet) ->
    @tweet = m.prop(tweet)
    @body()

  getEntities: =>
    twttr.extractEntitiesWithIndices @tweet().text,
      extractUrlsWithoutProtocol: false

  getUrlEntities: =>
    @tweet().entities.urls

  getUrlEntityFromUrl: (url) =>
    entities = @getUrlEntities().filter (urlEntity) => urlEntity.url is url
    entities[0]

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

  view: =>
      m ".tweet", [
        m ".profile-image", [
          m "img", { src: Helper.largeIcon(@vm.tweet().user) }
        ]
        m ".contents", [
          m ".name-contents", [
            m ".name", @vm.tweet().user.name
            m ".screen-name", "@#{@vm.tweet().user.screen_name}"
          ]
          m ".text", m.trust @vm.body()
          @vm.media()
        ]
      ]
