# A track function that does nothing and is perfectly useless.
nullTrack = ->

  data = {}

  track = (eventType, eventProperties) ->
    [eventType, eventProperties]

module.exports = nullTrack