ApplicationView = Ember.View.extend
  currentPathDidChange: (->
    Ember.run.next this, ->
      @$('ul.nav li:has(>a.active)').addClass 'active'
      @$('ul.nav li:not(:has(>a.active))').removeClass 'active'
  ).observes('controller.currentPath')

`export default ApplicationView`
