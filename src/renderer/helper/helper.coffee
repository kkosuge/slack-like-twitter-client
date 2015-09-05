shell = require('shell')

window.pp = (object) -> console.log JSON.stringify(object, null, 2)

module.exports = window.Helper =
  largeIcon: (user) =>
    user.profile_image_url.replace('_normal','_reasonably_small')

  openUrl: (url) =>
    shell.openExternal(url)
