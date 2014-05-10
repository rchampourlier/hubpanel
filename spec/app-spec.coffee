hubpanelApp = require '../lib/hubpanel-app'
nullTrack = require '../lib/null-track'
track = nullTrack()

request = require 'request'

get = (path, callback) ->
  request({
    method: 'GET'
    uri: 'http://localhost:8888' + path
    json: {} # so that the response body's JSON is parsed
  }, callback)

post = (path, jsonData, callback) ->
  request({
    method: 'POST'
    uri: 'http://localhost:8888' + path
    json: jsonData
  }, callback)

server = undefined
beforeEach -> server = hubpanelApp(track).listen 8888
afterEach -> server.close()

describe 'GET /status', ->
  it 'should respond ok', (done) ->
    get '/status', (error, response, body) ->
        expect(body).toEqual({"status": "ok"})
      done()

describe 'POST /github/events', ->

  describe 'push event', ->
    it 'should respond correctly', (done) ->
      data = 
        repository:
          owner:
            login: 'test-owner'
          name: 'test-repo-owner'
      post '/github/events', data, (error, response, body) ->
        expect(body).toEqual({"status": "ok"})
        done()
        