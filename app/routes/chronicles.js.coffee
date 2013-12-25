ChroniclesRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set 'model', @get('store').find 'chronicle'

`export default ChroniclesRoute`
