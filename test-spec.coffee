hubpanelServer = require './lib/hubpanel-server'
testTrack = require './lib/test-track'

track = testTrack()
server = hubpanelServer track
server.listen 8888

console.log 'You will have to terminate the server manually with CTRL-C!'

request = require 'request'

get = (path, callback) ->
  request 'http://localhost:8888' + path, callback

post = (path, jsonData, callback) ->
  request({
    method: 'POST'
    uri: 'http://localhost:8888' + path
    json: jsonData
  }, callback)

describe 'GET /status', ->
  it 'should respond ok', (done) ->
    get '/status', (error, response, body) ->
      expect(body).toEqual('{"status": "ok"}')
      done()

describe 'POST /github/events', ->

  describe 'push event', (done) ->
    it 'should respond correctly', ->
      data = 
        repository:
          owner:
            login: 'test-owner'
          name: 'test-repo'
      post '/github/events', data, (error, response, body) ->
        expect(body).toEqual('{"status": "ok"}')
        done()