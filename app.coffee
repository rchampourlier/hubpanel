hubpanelServer = require './lib/hubpanel-server'
mixpanelTrack = require './lib/mixpanel-track'

track = mixpanelTrack(process.env.MIXPANEL_PROJECT_ID)
server = hubpanelServer track
server.listen process.env.PORT || 8080