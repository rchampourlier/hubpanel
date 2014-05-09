Mixpanel = require 'mixpanel'

mixpanelTrack = (projectId) ->
  mixpanel = Mixpanel.init(projectId)

  track = (eventType, eventProperties) ->
    console.log 'mixpanel: %s %j', eventType, eventProperties
    mixpanel.track eventType, eventProperties

module.exports = mixpanelTrack