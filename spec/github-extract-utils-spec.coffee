subject = require '../lib/github-extract-utils'

describe 'GithubExtractUtils', ->

  describe '#baseRef', ->
    it 'should return the last component in a \':\'-joined array', ->
      expect(subject.baseRef('a/b/c')).toEqual 'c'