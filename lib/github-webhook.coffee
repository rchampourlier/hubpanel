jsonBody = require 'body/json'
githubExtract = require './github-extract'

githubWebhook = (track, req, callback) ->
  jsonBody req, null, (err, body) ->
    eventType = githubExtract.eventType(req)
    eventProperties = githubExtract.eventProperties(eventType, body)
    track eventType, eventProperties
    callback()

module.exports = githubWebhook