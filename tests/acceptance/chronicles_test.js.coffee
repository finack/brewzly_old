App = undefined

module 'Feature - Chronicles',
  setup: ->
    App = startApp()
    fakehr.start()

  teardown: ->
    fakehr.reset()
    Ember.run App, 'destroy'

test 'basic page for chronicles', ->
  visit '/chronicles'
  andThen ->
    ok exists("nav"), 'The navbar rendored'
    ok exists("nav .navbar-collapse li.active a:contains('Chronicles')"), 'Navbar has Chronicle link and it is active'

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
    equal rows, 3

test 'Add new chronicle', ->
  expect 5

  visit('/chronicles')

  andThen ->
    equal $(".modal:hidden").length, 1, "Modal should not be visible"
    click ".panel-body button"

    andThen ->
      fillIn ".modal input#name", "Hello World"
      equal find(".modal input#name").val(), "Hello World", "Enter chronicle's name"
      click ".modal button.btn-primary"

      andThen ->
        response = JSON.parse fakehr.match('POST', '/api/chronicles').requestBody
        ok response
        response.chronicle.id = '1234'
        httpRespond "post", "/api/chronicles", response

        andThen ->
          equal App.__container__.lookup('router:main').location.path, '/chronicle/1234'
          equal $(".container:contains('Hello World')").length, 1, "Find the new chroncile in the results"

test 'Abort adding new chronicle', ->
  expect 3

  visit('/chronicles')

  andThen ->
    equal $(".modal:hidden").length, 1, "Modal should not be visible"
    click ".panel-body button"

    andThen ->
      click "button:contains('Close')"

      andThen ->
        ok not fakehr.match('POST', '/api/chronicles'), "Server should not have recieved any updates"
        equal $(".modal:hidden").length, 1, "Modal should not be visible"

