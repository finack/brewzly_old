App = undefined
module "Acceptances - Home",
  setup: ->
    App = startApp()

  teardown: ->
    Ember.run App, "destroy"

test "Home renders", ->
  expect 3
  visit("/").then ->
    title = find("h2#title")
    list = find("ul li")
    equal title.text(), "Welcome to Ember"
    equal list.length, 3
    equal list.text(), "redyellowblue"
