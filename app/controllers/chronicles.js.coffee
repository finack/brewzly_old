ChroniclesController = Ember.ArrayController.extend
  # itemController: 'ChronicleController'
  sortProperties: ['brewedMoment']
  sortAscending: true


  actions:
    createChronicle: ->
      name = @get 'newChronicle'
      # brewdate = new Date(Ember.Date.parse(@get 'brewdate'))
      brewedAt = @get 'brewedAt'
      return unless name.trim

      chronicle = @store.createRecord( 'chronicle',
        name: name
        brewedAt: brewedAt.toJSON()
        isCompleted: false
      )

      onSucess = (resp) =>
        Ember.Logger.info "chronicleModel saved id:#{chronicle.id} name:#{chronicle.get 'name'}"
        $('#new_chronicle').modal('hide')
        @transitionToRoute('chronicle', resp)

      onFailure = (resp) ->
        Ember.Logger.error "chronicleModel could not save id:#{chronicle.id} name:#{chronicle.get 'name'}"
        chronicle.deleteRecord()
        $('#new_chronicle').modal('hide')
        alert "Could not save #{chronicle.get 'name'}"

      @set 'newChronicle', ''
      chronicle.save().then onSucess, onFailure
    
    deleteChronicle: (chronicle)->
      chronicle.deleteRecord()
      chronicle.save()

    clearChronicleModal: ->
      @set 'newChronicle', ''

      $('#new_chronicle').modal('hide')

`export default ChroniclesController`
