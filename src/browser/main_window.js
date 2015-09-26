import BrowserWindow from 'browser-window'

export default class MainWindow {
  constructor() {
    this.window = new BrowserWindow({
      width: 1000,
      height: 800,
      'title-bar-style': 'hidden-inset',
    });

    this.window.loadUrl(`file://${__dirname}/../index.html`);
    this.window.openDevTools();
    this.window.on('closed', () => {
      window = null
    });
  }
}
