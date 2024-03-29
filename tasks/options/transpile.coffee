grunt = require("grunt")
module.exports =
  tests:
    type: "amd"
    moduleName: (path) ->
      grunt.config.process("<%= package.namespace %>/tests/") + path

    files: [
      expand: true
      cwd: "tmp/javascript/tests/"
      src: "**/*.js"
      dest: "tmp/transpiled/tests/"
    ]

  app:
    type: "amd"
    moduleName: (path) ->
      grunt.config.process("<%= package.namespace %>/") + path

    files: [
      expand: true
      cwd: "tmp/javascript/app/"
      src: "**/*.js"
      dest: "tmp/transpiled/app/"
    ]
