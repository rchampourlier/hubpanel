express = require 'express'
githubWebhook = require './github-webhook.coffee'

server = (track) ->
  server = express()

  success = (res) ->
    res.type 'application/json'
    res.send '{"status": "ok"}'

  server.get '/status', (req, res) ->
    success(res)

  # POST /github/events
  server.post '/github/events', (req, res) ->
    githubWebhook track, req, ->
      success(res)

  server

module.exports = server