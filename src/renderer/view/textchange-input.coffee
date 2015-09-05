m = require 'mithril'

factory = (tag) ->
  controller: (args) ->
    composing = null
    oldValue = null
    element = null
    composing = null
    setComposing = -> composing = true
    resetComposing = -> composing = false
    onInput = (e) ->
      if (!composing && e.target.value isnt oldValue)
        if (args && args.ontextchange)
          args.ontextchange
            currentTarget: element,
            target: element
        oldValue = e.target.value
    {
      config: (elem, isInitialized, context) ->
        if (!isInitialized)
          element = elem
          oldValue = element.value
          element.addEventListener('compositionstart', setComposing)
          element.addEventListener('compositionend', resetComposing)
          element.addEventListener('input', onInput)
          context.onunload = ->
            element.removeEventListener('compositionstart', setComposing)
            element.removeEventListener('compositionend', resetComposing)
            element.removeEventListener('input', onInput)
    }
  view: (ctrl, args) ->
    args.config = ctrl.config
    m(tag, args)

module.exports = TextchangeInput = factory('input')
