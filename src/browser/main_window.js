import BrowserWindow from 'browser-window'

export default class MainWindow {
  constructor() {
    this.window = new BrowserWindow({
      width: 1200,
      height: 900
    });

    this.window.loadUrl(`file://${__dirname}/../index.html`);
    this.window.on('closed', () => {
      window = null
    });
  }
}
