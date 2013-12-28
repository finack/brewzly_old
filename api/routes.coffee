debug = require("debug")("api:routes")

module.exports = (app,db) ->
  
  app.namespace "/api", ->

    app.namespace '/chronicles', ->

      # Find All
      app.get '/', (req, res) ->
        db.findChronicles (err, chronicles) ->
          debug "[DEBUG][/api/chronicles] count:%s -> {error:%j}", chronicles.length, err
          if err
            res.send 500
            return

          if chronicles is null
            res.send 404
          else
            res.send { "chronicles": chronicles }
      
      # Create
      app.post '/', (req, res) ->
        post = req.body.chronicle
        db.saveChronicle post, (err, chronicle) ->
          debug "[DEBUG][POST /api/chronicles] %j : %j", err, chronicle

          if chronicle is false
            res.send 422
          else
            res.send { "chronicle": chronicle }
    
    app.namespace '/chronicles/:id', ->

      # Find
      app.get '/', (req, res) ->
        id = req.param('id')
        db.findChronicle id, (err, chronicle) ->
          debug "[DEBUG][/api/chronicle] count:%s -> {error:%j}", chronicle.length, err
          if err
            res.send 500
            return

          if chronicle is null
            res.send 404
          else
            res.send { "chronicles": chronicle }
      
      # Update
      app.put '/', (req, res) ->
        res.send('GET forum ' + req.params.id + ' edit page')

      # Delete
      app.del '/', (req, res) ->
        id = req.param('id')
        db.deleteChronicle id, (err, results) ->
          debug "[DEBUG][DELETE /api/chronicles] %j : %j", err, id
          if err or results is false
            res.send 500
            return

          res.send 204
