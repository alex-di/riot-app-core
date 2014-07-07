extend = `function (){var a,b,c,d,e,f,g=arguments[0]||{},h=1,i=arguments.length,j=!1;for("boolean"==typeof g&&(j=g,g=arguments[h]||{},h++),"object"==typeof g||m.isFunction(g)||(g={}),h===i&&(g=this,h--);i>h;h++)if(null!=(e=arguments[h]))for(d in e)a=g[d],c=e[d],g!==c&&(j&&c&&(m.isPlainObject(c)||(b=m.isArray(c)))?(b?(b=!1,f=a&&m.isArray(a)?a:[]):f=a&&m.isPlainObject(a)?a:{},g[d]=m.extend(j,f,c)):void 0!==c&&(g[d]=c));return g}`
if window?
  global = window
  unless global.riot?
    throw "riot not defined"
  riot = global.riot
else
  global = exports
  riot = require "./riotjs"
# only single global variable is exposed

App = (conf) ->
  self = riot.observable(@)
  self = extend self, conf

  # Fake delay for correct event triggering
  setTimeout ->
    self.trigger "ready"
  , 1
  return self

app = riot.observable (arg) ->

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

global.app = app