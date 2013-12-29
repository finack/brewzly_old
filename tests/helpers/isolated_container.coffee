`import Resolver from 'resolver'`

isolatedContainer = (fullNames) ->
  container = new Ember.Container()

  container.optionsForType "component",
    singleton: false

  container.optionsForType "view",
    singleton: false

  container.optionsForType "template",
    instantiate: false

  container.optionsForType "helper",
    instantiate: false

  resolver = Resolver["default"].create()
  resolver.namespace = modulePrefix: "brewzly"

  i = fullNames.length

  while i > 0
    fullName = fullNames[i - 1]
    container.register fullName, resolver.resolve(fullName)
    i--
  container

`export default isolatedContainer`
