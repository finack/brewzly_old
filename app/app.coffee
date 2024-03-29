`import Resolver from 'resolver'`

App = Ember.Application.extend(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  modulePrefix: "brewzly"
  Resolver: Resolver["default"]
)

Ember.RSVP.configure "onerror", (error) ->
  
  # ensure unhandled promises raise awareness.
  # may result in false negatives, but visibility is more important
  if error instanceof Error
    Ember.Logger.assert false, error
    Ember.Logger.error error.stack

`export default App`
