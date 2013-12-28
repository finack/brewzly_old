ChroniclesController = Ember.ArrayController.extend
  actions:
    createChronicle: ->
      name = @get 'newChronicle'
      return unless name.trim

      chronicle = @store.createRecord( 'chronicle',
        name: name
        isCompleted: false
      )

      onSucess = (resp) =>
        $('#new_chronicle').modal('hide')
        @transitionToRoute('chronicle', resp)

      onFailure = (resp) ->
        chronicle.deleteRecord()
        $('#new_chronicle').modal('hide')
        alert "Could not save #{chronicle.name}"

      @set 'newChronicle', ''
      chronicle.save().then onSucess, onFailure
    
    deleteChronicle: (chronicle)->
      chronicle.deleteRecord()
      chronicle.save()

    clearChronicleModal: ->
      @set 'newChronicle', ''

      $('#new_chronicle').modal('hide')

`export default ChroniclesController`
