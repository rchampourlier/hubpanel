_ = require 'lodash'
track = require '../lib/test-track'
githubExtract = require '../lib/github-extract'

baseBody =
  repository:
    owner:
      login: 'test-owner'
    name: 'test-repo'

describe 'github-extract', ->

  describe 'eventType', ->

    it 'should return the value of request\'s X-Github-Event header', ->
      req = 
        get: (arg) -> if arg == 'X-GitHub-Event' then 'test-event' else ''
      expect(githubExtract.eventType(req)).toEqual 'test-event'

  describe 'eventProperties', ->

    describe 'ping event', ->
      it 'should return no properties', ->
        body =
          hook_id: '123456'
          zen: 'Some obscure zen thought'
        expect(githubExtract.eventProperties('ping', body)).toEqual {}

    describe 'push event', ->
      it 'should return the expected properties', ->
        body = _.extend baseBody,
          ref: 'refs/heads/test-ref'
          size: 'test-size'
          pusher:
            name: 'test-user'
        expect(githubExtract.eventProperties('push', body)).toEqual
          owner: 'test-owner'
          repo: 'test-repo'
          ref: 'test-ref'
          size: 'test-size'
          user: 'test-user'

    describe 'commit comment event', ->
      it 'should return the expected properties', ->
        body = _.extend baseBody,
          created_at: 'test-creation'
          comment:
            user:
              login: 'test-user'
            body:
              length: 'test-size'
        expect(githubExtract.eventProperties('commit_comment', body)).toEqual
          owner: 'test-owner'
          repo: 'test-repo'
          creation: 'test-creation'
          size: 'test-size'
          user: 'test-user'