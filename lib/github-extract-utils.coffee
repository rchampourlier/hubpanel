_ = require 'lodash'

class GithubExtractUtils

  baseRef: (ref) -> _.last(ref.split('/'))

  distinctId: (repo, repo_owner, ref) -> [repo_owner, repo, ref].join(':')

  extract: (type, properties) ->
    {
      eventType: type
      eventProperties: properties
    }

module.exports = new GithubExtractUtils()