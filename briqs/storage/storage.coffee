state = require '../../server/state'
level = require 'level'

db = level './storage', {}, (err) ->
  throw err  if err
  if true
    console.log 'db opened', db.db.getProperty 'leveldb.stats'
    db.db.approximateSize ' ', '~', (err, size) ->
      throw err  if err
      console.log 'storage size ~ %d bytes', size

processValue = (obj, oldObj) ->
  dbkey = "reading~#{obj.key}~#{obj.time}"
  db.put dbkey, obj.origval, (err) ->
    throw err  if err

module.exports = class
  constructor: ->
    state.on 'set.status', processValue
  destroy: ->
    state.off 'set.status', processValue