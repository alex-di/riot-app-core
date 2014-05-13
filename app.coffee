if window?
  global = window
  unless riot?
    throw "riot not defined"
else
  global = exports
  riot = require "riotjs"
# only single global variable is exposed

App = (conf) ->
  self = riot.observable(@)
  $.extend self, conf

  # Fake delay for correct event triggering
  setTimeout ->
    self.trigger "ready"
  , 1

global.app = riot.observable (arg) ->

# when called without argument, the API is returned
  return instance unless arg

  # function argument --> bind a new module
  if $.isFunction arg
    app.on "ready", arg

    # configuration argument
  else
    instance = new App arg
    instance.on "ready", ->
      app.trigger "ready", instance