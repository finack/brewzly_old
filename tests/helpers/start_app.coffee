`import Application from 'brewzly/app'`
`import Router from 'brewzly/router'`

startApp = (attrs) ->
  App = undefined

  attributes = Ember.merge(
    rootElement: "#ember-testing"
    LOG_ACTIVE_GENERATION: false
    LOG_VIEW_LOOKUPS: false
  , attrs)

  Ember.run.join ->
    App = Application.create(attributes)
    App.setupForTesting()
    App.injectTestHelpers()

  Router.reopen location: "none"

  App.reset() # this shouldn't be needed, i want to be able to "start an app at a specific URL"

  App

`export default startApp`
