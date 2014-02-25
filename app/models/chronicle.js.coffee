ChronicleModel = DS.Model.extend
  name: DS.attr 'string'
  brewedAt: DS.attr 'string'

  brewedMoment: (->
    moment.utc(@get 'brewedAt')
  ).property('brewedAt')


`export default ChronicleModel`
