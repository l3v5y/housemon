should = require('chai').Should()

lightNode = require '../../drivers/lightNode'

describe 'lightNode', ->

  it 'should have a decode function', ->
    should.exist(lightNode.decode)

  it 'should have an announcer', ->
    should.exist(lightNode.announcer)

  it 'should have a description', ->
    should.exist(lightNode.descriptions)

  it 'should listen for rf12.packets', ->
    lightNode.feed.should.equal('rf12.packet')

  it 'should decode a valid package', ->
    rawData = new Buffer([0,128])
    lightNode.decode rawData, (retVal)=> 
      retVal.value.should.equal(128)