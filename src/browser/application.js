import app from 'app'
import BrowserWindow from 'browser-window'
import MainWindow from './main_window'

global.twitter_credentials = {
  consumer_key: 'b5vOZ3RqJMuOD3HAAuDWib6ZX',
  consumer_secret: '2HGGzCwXhxuuHfx56b4rBf5XWSWeRweLdAcVJKd6jCbObs5eiu',
}

export default class Application {
  constructor() {
    global.application = this;
    app.on('window-all-closed', () => {});
    app.on('ready', this.onReady.bind(this));
  }

  onReady() {
    new MainWindow();
  }
}
