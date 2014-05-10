jsonBody = require 'body/json'
githubExtract = require './github-extract'

githubWebhook = (track, req, callback) ->
  jsonBody req, null, (err, body) ->
    extract = githubExtract(req, body)
    track extract.eventType, extract.eventProperties
    callback()

module.exports = githubWebhook