request = require "request"

class Requester
  get: (path, callback) ->
    request "http://localhost:3000#{path}", callback

  post: (path, body, callback) ->
    request.post {url: "http://localhost:3000#{path}", body: body}, callback

exports.withServer = (callback) ->
  asyncSpecWait()

  {app} = require "./server.coffee"


  server = app.listen 3000
  console.log 'app started'
  
  stopServer = ->
    server.close()
    asyncSpecDone()

  callback new Requester, stopServer
