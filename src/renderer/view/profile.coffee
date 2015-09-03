Account = require '../model/account'
m = require 'mithril'

class ViewModel
  constructor: ->
    @user = m.prop(global.accounts[0].user)
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
