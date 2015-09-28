import { EventEmitter2 } from 'eventemitter2'

if (!window.emitter) {
  window.emitter = new EventEmitter2()
}
