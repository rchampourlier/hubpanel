_ = require 'lodash'

baseProperties = (body) ->
  {
    owner:  body.repository.owner.login
    repo:  body.repository.name    
  }

pushProperties = (body) ->
  {
    ref:   body.ref.replace 'ref/heads/', ''
    size:  body.size
    user:  body.pusher.name
  }

commitCommentProperties = (body) ->
  {
    user:       body.comment.user.login
    size:       body.comment.body.length
    creation:   body.created_at
  }

githubExtract =

  eventType: (req) ->
    req.get 'X-GitHub-Event'

  eventProperties: (type, body) ->
    if body?
      properties = switch type
        when 'test_event' then {}
        when 'push' then pushProperties(body)
        when 'commit_comment' then commitCommentProperties(body)
        else undefined
      _.extend(properties, baseProperties(body))
    else
      {}

module.exports = githubExtract