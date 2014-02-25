ChronicleController = Ember.ObjectController.extend
  brewedDateDisplay: (->
    @get('brewedMoment').format('MMM D, YYYY')
  ).property('brewedMoment')

`export default ChronicleController`

