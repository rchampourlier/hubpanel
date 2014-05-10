_ = require 'lodash'
utils = require './github-extract-utils'

pingExtract = ->
  utils.extract 'ping', {}

pushExtract = (body) ->
  ref         = utils.baseRef(body.ref)
  repo        = body.repository.name
  repo_owner  = body.repository.owner.name
  utils.extract 'push',
    repo:         repo
    repo_owner:   repo_owner
    distinct_id:  utils.distinctId(repo, repo_owner, ref)
    ref:          ref
    user:         body.pusher.name

pullRequestExtract = (body) ->
  ref         = body.pull_request.head.ref
  repo        = body.repository.name
  repo_owner  = body.repository.owner.login
  utils.extract 'pull_request_' + body.action,
    repo:         repo
    repo_owner:   repo_owner
    distinct_id:  utils.distinctId(repo, repo_owner, ref)
    ref:          ref
    user:         body.pull_request.user.login
    base_ref:     body.pull_request.base.ref

commitCommentExtract = (body) ->
  repo        = body.repository.name
  repo_owner  = body.repository.owner.login
  extract = utils.extract 'commit_comment',
    #distinct_id:  utils.distinctId(repo, repo_owner, ref) # ref N/A
    repo:             repo
    repo_owner:       repo_owner
    message_length:   body.comment.body.length
    user:             body.comment.user.login
  extract

githubExtract = (req, body) ->
  githubType = req.get 'X-GitHub-Event'
  if body?
    switch githubType
      when 'ping'           then pingExtract()
      when 'push'           then pushExtract(body)
      when 'pull_request'   then pullRequestExtract(body)
      when 'commit_comment' then commitCommentExtract(body)
      else {}
  else
    {}

module.exports = githubExtract