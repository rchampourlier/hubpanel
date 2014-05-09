_ = require 'lodash'

baseProperties = (body) ->
  {
    owner:  body.repository.owner.login
    repo:  body.repository.name    
  }

pushProperties = (body) ->
  _.extend baseProperties(body),
    ref:   body.ref.replace 'refs/heads/', ''
    size:  body.size
    user:  body.pusher.name

commitCommentProperties = (body) ->
  _.extend baseProperties(body),
    user:       body.comment.user.login
    size:       body.comment.body.length
    creation:   body.created_at

githubExtract =

  eventType: (req) ->
    req.get 'X-GitHub-Event'

  eventProperties: (type, body) ->
    if body?
      switch type
        when 'test_event'     then {}
        when 'ping'           then {}
        when 'push'           then pushProperties(body)
        when 'commit_comment' then commitCommentProperties(body)
        else undefined
    else
      {}

module.exports = githubExtract