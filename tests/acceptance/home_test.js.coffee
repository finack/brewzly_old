App = undefined
module 'Feature - Home Page',
  setup: ->
    App = startApp()

  teardown: ->
    Ember.run App, 'destroy'

test 'renders', ->
  expect 2
  visit('/').then ->
    title = find '.wrapper nav.navbar .navbar-header a'
    equal title.text(), "Brewzly"

    chronicles = find '.wrapper nav.navbar .navbar-collapse ul'
    equal chronicles.text(), "Chronicles"
    
    # list = find("ul li")
    # equal list.length, 3
    # equal list.text(), "redyellowblue"
