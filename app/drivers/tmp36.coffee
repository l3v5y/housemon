module.exports = (app) ->

  app.register 'driver.tmp36',
    in: 'Buffer'
    out:
      temp:
        title: 'Temperature', unit: '°C'
        scale: 0, min: -40, max: 120

    decode: (data) ->
      t = data.msg.readUInt16LE(1) >> 1 & 0x7FFF
      temp = ((t*3.3/1024*1000) - 500)/10
      { temp: temp }
