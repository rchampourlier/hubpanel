testTrack = ->

  data = {}

  track = (eventType, eventProperties) ->
    data.type = eventType
    data.properties = eventProperties
    console.log 'test: %s %j', eventType, eventProperties

module.exports = testTrack