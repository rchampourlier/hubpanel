_ = require 'lodash'
githubExtract = require '../lib/github-extract'

class SpecReq
  constructor: (@githubType) ->
  get: (key) -> if key is 'X-GitHub-Event' then @githubType else undefined

describe 'githubExtract()', ->

  describe 'ping event', ->
    req = new SpecReq 'ping'
    body =
      hook_id: '123456'
      zen: 'Some obscure zen thought'

    it 'should extract a \'ping\' event type', ->
      expect(githubExtract(req, body).eventType).toEqual 'ping'

    it 'should extract empty properties', ->
      expect(githubExtract(req, body).eventProperties).toEqual {}

  describe 'push event', ->
    req = new SpecReq 'push'
    body =
      repository:
        owner:
          name: 'test-repo-owner'
        name: 'test-repo'
      ref: 'refs/heads/test-ref'
      size: 'test-size'
      pusher:
        name: 'test-user'

    it 'should extract a \'push\' event type', ->
      expect(githubExtract(req, body).eventType).toEqual 'push'

    it 'should extract the expected properties', ->
      expect(githubExtract(req, body).eventProperties).toEqual
        distinct_id: 'test-repo-owner:test-repo:test-ref'
        repo_owner: 'test-repo-owner'
        repo:       'test-repo'
        ref:        'test-ref'
        user:       'test-user'

  describe 'pull event', ->
    req = new SpecReq 'pull_request'
    pullRequestBaseBody =
      repository:
        owner:
          login: 'test-repo-owner'
        name: 'test-repo'
      pull_request:
        user:
          login: 'test-user'
        head:
          ref: 'test-ref'
        base:
          ref: 'test-base-ref'

    describe 'opened', ->

      it 'should extract a \'pull_request_opened\' event type', ->
        body = _.extend pullRequestBaseBody, { action: 'opened' }
        expect(githubExtract(req, body).eventType).toEqual 'pull_request_opened'

      it 'should extract the expected properties', ->
        body = _.extend pullRequestBaseBody, { action: 'opened' }
        expect(githubExtract(req, body).eventProperties).toEqual
          distinct_id: 'test-repo-owner:test-repo:test-ref'
          repo_owner: 'test-repo-owner'
          repo: 'test-repo'
          ref: 'test-ref'
          base_ref: 'test-base-ref'
          user: 'test-user'

    describe 'closed', ->

      it 'should extract a \'pull_request_closed\' event type', ->
        body = _.extend pullRequestBaseBody, { action: 'closed' }
        expect(githubExtract(req, body).eventType).toEqual 'pull_request_closed'

  describe 'commit comment event', ->
    req = new SpecReq 'commit_comment'
    body =
      repository:
        owner:
          login: 'test-repo-owner'
        name: 'test-repo'
      comment:
        user:
          login: 'test-user'
        body:
          length: 'test-size'

    it 'should extract a \'commit_comment\' event type', ->
      expect(githubExtract(req, body).eventType).toEqual 'commit_comment'

    it 'should extract the expected properties', ->
      expect(githubExtract(req, body).eventProperties).toEqual
        #distinct_id:    'test-repo-owner:test-repo:test-ref'
        repo_owner:     'test-repo-owner'
        repo:           'test-repo'
        message_length: 'test-size'
        user:           'test-user'