DateFieldComponent = Ember.TextField.extend
  didInsertElement: ->
    @.$().datepicker().on 'changeDate', (e) =>
      @set 'date', e.date
      @.$().trigger('change')

`export default DateFieldComponent`
