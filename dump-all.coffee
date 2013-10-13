level = require 'level'

db = level 'storage'
db.createReadStream().on 'data', (data) ->
  console.log data.key, '=', data.value
