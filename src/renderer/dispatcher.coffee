Dispatcher = require('flux').Dispatcher

global.dispatcher ||= new Dispatcher
module.exports = global.dispatcher
