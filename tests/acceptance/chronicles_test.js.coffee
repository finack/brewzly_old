App = undefined

module 'Feature - Chronicles',
  setup: ->
    App = startApp()
    fakehr.start()

  teardown: ->
    fakehr.reset()
    Ember.run App, 'destroy'

test 'display list of chronicles', ->
  # expect 2
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

  visit('/chronicles')
  httpRespond("get", "/api/chronicles", chronicles)
  andThen ->
    rows = findWithAssert('.list-group .list-group-item').length
    equal(rows, 3)
