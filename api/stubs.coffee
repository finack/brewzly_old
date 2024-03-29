module.exports = (server) ->
  
  server.namespace "/api", ->

    server.get '/chronicles', (req, res) ->
      chronicles = 
        chronicles: [
          {
            id: 1
            name: "Batch 33 - Golden Brown"
            brewdate: "???"
          }
          {
            id: 2
            name: "Batch 60 - Brown Promise"
            brewdate: "???"
          }
          {
            id: 3
            name: "Batch 77 - Reverse Cowgirl"
            brewdate: "???"
          }
        ]

      res.send chronicles
    
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
