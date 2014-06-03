Object.defineProperty Object.prototype, "extend",
    enumerable: false,
    value: (from) ->
      props = Object.getOwnPropertyNames(from);
      dest = @;
      props.forEach (name) ->
        if (name in dest)
          destination = Object.getOwnPropertyDescriptor(from, name)
          Object.defineProperty(dest, name, destination)
      return @;


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
  self.extend conf

  # Fake delay for correct event triggering
  setTimeout ->
    self.trigger "ready"
  , 1
  return self

global.app = riot.observable (arg) ->

# when called without argument, the API is returned
  return instance unless arg

  # function argument --> bind a new module
  if typeof arg is "function"
    app.on "ready", arg

    # configuration argument
  else
    instance = new App arg
    instance.on "ready", ->
      app.trigger "ready", instance
