should = require('chai').Should()

describe 'smaRelay', ->
  beforeEach ->
    @smaRelay = require '../../drivers/smaRelay'
    @smaRelay.prev = null

  rawData = ->
    new Buffer([0,0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11]);

  it 'should have a decode function', ->
    should.exist(@smaRelay.decode)

  it 'should have an announcer', ->
    should.exist(@smaRelay.announcer)

  it 'should have a description', ->
    should.exist(@smaRelay.descriptions)

  it 'should listen for rf12.packets', ->
    @smaRelay.feed.should.equal('rf12.packet')

  it 'should report all values initially', ->
    @smaRelay.decode rawData(), (retVal) =>
      retVal.yield.should.equal(0)
      retVal.total.should.equal(1)
      retVal.acw.should.equal(2)
      retVal.dcv1.should.equal(3)
      retVal.dcv2.should.equal(4)
      retVal.dcw1.should.equal(5)
      retVal.dcw2.should.equal(6)

  it 'should only report aggregated values when they actually change', ->
    packet = rawData()
    @smaRelay.decode packet, (retVal) =>
      retVal.yield.should.equal(0)
      retVal.total.should.equal(1)
    @smaRelay.decode packet, (retVal) =>
      should.not.exist(retVal.yield)
      should.not.exist(retVal.total)
      