shell = require('shell')

module.exports = window.Helper =
  largeIcon: (user) =>
    user.profile_image_url.replace('_normal','_reasonably_small')

  openUrl: (url) =>
    shell.openExternal(url)
