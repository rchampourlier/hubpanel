_ = require 'lodash'
express  = require 'express'
jsonBody = require 'body/json'
Mixpanel = require 'mixpanel'
mixpanel = Mixpanel.init process.env.MIXPANEL_PROJECT_ID

app = express()

success = (res) ->
  res.type 'application/json'
  res.send '{"result": "ok"}'

githubTrack = (req, res) ->
  githubEventProperties req, (properties) ->
    track githubEventName(req), properties
    success res

githubEventName = (req) ->
  req.get 'X-GitHub-Event'

githubEventProperties = (req, callback) ->
  jsonBody req, null, (err, body) ->
    body = {} unless body?
    properties = _.extend body,
      owner: req.params.owner
      repo: req.params.repo
    callback properties

track = (name, properties) ->
  console.log 'TRACK-EVENT %s %j', name, properties
  mixpanel.track name, properties

# POST /github/events
app.post '/github/events/:owner/:repo', (req, res) ->
  githubTrack req, res

app.listen(process.env.PORT || 8080)