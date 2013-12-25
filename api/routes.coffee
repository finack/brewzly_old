debug = require("debug")("api:routes")

module.exports = (server,db) ->
  
  server.namespace "/api", ->

    server.get '/chronicles', (req, res) ->
      db.findChronicles (err, chronicles) ->
        debug "[DEBUG][/api/chronicles] count:%s -> {error:%j}", chronicles.length, err
        if err
          res.send 500
          return

        if chronicles is null
          res.send 404
        else
          res.send { "chronicles": chronicles }
    
    # Return fixture data for '/api/posts/:id'
    server.get "/chronicle/:id", (req, res) ->
      chronicle =
        chronicle:
          id: 1
          name: "Batch 33 - Golden Brown"
          brewdate: "???"
          chapters: [
            "1"
            "2"
          ]

        chapters: [
          {
            id: "1"
            body: "Rails is unagi"
          }
          {
            id: "2"
            body: "Omakase O_o"
          }
        ]

      res.send chronicle
