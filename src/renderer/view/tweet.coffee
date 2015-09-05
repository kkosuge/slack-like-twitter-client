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

  body: =>
    body = twttr.htmlEscape(@tweet().text)
    if @tweet().entities.urls.length
      @tweet().entities.urls.forEach (entity) =>
        body = body.replace(entity.url,
        """<a onclick="Helper.openUrl('#{entity.url}')">#{entity.display_url}</a>""")

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
        ]
      ]
