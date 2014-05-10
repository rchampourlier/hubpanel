hubpanelApp = require './lib/hubpanel-app'
mixpanelTrack = require './lib/mixpanel-track'
logTrack = require './lib/log-track'

track = mixpanelTrack(process.env.MIXPANEL_PROJECT_ID)
#track = logTrack()

app = hubpanelApp track
server = app.listen process.env.PORT || 8080