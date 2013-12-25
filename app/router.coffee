Router = Ember.Router.extend()

Router.reopen
  location: 'history'

Router.map ->
  @resource 'chronicles'
  # @resource 'chronicle', { path: '/chronicle/:chronicle_id' }

  @route 'component-test'
  @route 'helper-test'

`export default Router`
