Account = require '../model/account'
m = require 'mithril'

class ViewModel
  constructor: ->
    @user = m.prop({})

    @account = new Account
    @account.ready
      #.then =>
      #  @model.clear()
      .then =>
        @account.all()
      .then (accounts) =>
        account = accounts[0]
        account = if account? then account else {}
        @user(account.user)
        m.redraw()

module.exports =
class Profile
  constructor: ->
    @vm = new ViewModel

  view: =>
    m ".user", [
      m ".profile-image", [
        m "img", { src: @vm.user().profile_image_url }
      ]
      m ".screen-naml", "@#{@vm.user().screen_name}"
    ]
