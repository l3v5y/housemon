module.exports = (app, plugin) ->
  
  config = require('./config');

  app.register node.id, node.driver for node in config.nodes

  app.on 'running', ->
    Logger = @registry.sink.logger
    Replayer = @registry.pipe.replayer
    Serial = @registry.interface.serial
    Parser = @registry.pipe.parser
    Dispatcher = @registry.pipe.dispatcher
    ReadingLog = @registry.sink.readinglog
    StatusTable = @registry.sink.statustable
    createLogStream = @registry.source.logstream

    # app.db.on 'put', (key, val) ->
    #   console.log 'db:', key, '=', val
    # app.db.on 'batch', (array) ->
    #   console.log 'db#', array.length
    #   for x in array
    #     console.log ' ', x.key, '=', x.value
      
    readings = createLogStream('app/replay/20121130.txt.gz')
      .pipe(new Replayer)
      .pipe(new Parser)
      .pipe(new Dispatcher)

    readings
      .pipe(new ReadingLog app.db)

    readings
      .pipe(new StatusTable app.db)

    jeelink = new Serial(config.serialDevice).on 'open', ->

      jeelink # log raw data to file, as timestamped lines of text
          .pipe(new Logger) # sink, can't chain this further

      jeelink # log decoded readings as entries in the database
          .pipe(new Parser)
          .pipe(new Dispatcher)
          .pipe(new ReadingLog app.db)

      jeelink
          .pipe(new StatusTable app.db)
