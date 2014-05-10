logTrack = ->

  data = {}

  track = (eventType, eventProperties) ->
    data.type = eventType
    data.properties = eventProperties
    console.log 'log: %s %j', eventType, eventProperties

module.exports = logTrack