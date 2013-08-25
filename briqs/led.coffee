exports.info =
  version: '0.1.0'
  name: 'l3v5y-led'
  description: 'A basic RGB LED controller'
  descriptionHtml: '' 
  author: 'l3v5y'
  authorUrl: 'http://l3v5y.co.uk'
  briqUrl: '/docs/#l3v5y-led.md'
  menus: [
    title: 'LED'
    controller: 'LEDCtrl'
  ]
  connections:
    results:
      'readings': 'collection'
  
state = require '../server/state'
_ = require 'underscore'
RF12RegistryManager = require('./rf12registrymanager.coffee').RF12RegistryManager

exports.factory = class
  constructor: (device) ->
    info = key: 'led', r: 0, g: 0, b: 0, band: 868, group: 100, node: 2
    state.store 'readings', _.extend {}, info
    @_registry = new RF12RegistryManager.Registry()
    @_debug = false
    @someprop = false

    adjustLeds = (obj) =>
      info = obj
      message = "#{info.r},#{info.g},#{info.b}"
      @_registry.write info.band, info.group, info.node, 1, message
  
    state.on 'set.readings', (obj, oldObj) ->
      if obj?.key is 'led'
        adjustLeds obj

  destroy: ->
    try
      @_registry.destroy()
    catch err

  setDebug : (flag) =>
    return @_debug = flag
  
  getDebug : () =>
    return @_debug 

  dump : () =>
    return JSON.stringify @, (key, value) ->
      return value