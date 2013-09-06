should = require('chai').Should()
roomNode = require '../../drivers/roomNode'

describe 'roomNode', ->
  it 'should have a decode function', ->
    should.exist(roomNode.decode)

  it 'should have an announcer', ->
    should.exist(roomNode.announcer)

  it 'should have a description', ->
    should.exist(roomNode.descriptions)

  it 'should listen for rf12.packets', ->
    roomNode.feed.should.equal('rf12.packet')

  it 'should decode light level correctly', ->
    rawData = new Buffer([0,128,0,0])
    roomNode.decode rawData, (retVal) =>
      retVal.light.should.equal(128)

  it 'should decode humidity correctly', ->
    rawData = new Buffer([0, 0, 32, 0])
    roomNode.decode rawData, (retVal) =>
      retVal.humi.should.equal(16)

  it 'should decode moved correctly', ->
    rawData = new Buffer([0, 0, 31, 0])
    roomNode.decode rawData, (retVal) =>
      retVal.moved.should.equal(1)

  it 'should decode positive temps correctly', ->
    rawData = new Buffer([0, 0, 0, 32])
    roomNode.decode rawData, (retVal) =>
      retVal.temp.should.equal(32)

  it 'should decode positive temps correctly', ->
    rawData = new Buffer([0, 0, 0, 1024])
    roomNode.decode rawData, (retVal) =>
      retVal.temp.should.equal(0)