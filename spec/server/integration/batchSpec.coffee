helper = require '../../spec_helper'

describe 'Server : Integration : Batch', ->
  describe 'get /chronicles', ->
    it 'responds successfully', ->
      helper.withServer (r, done) ->
        
        r.get '/chronicles', (err, res, body) ->
          # console.log err, res, body
          expect(body).toEqual 'hello world'
          done()
