Helpers   = require("../helpers")
scripts   = "{app,tests}/**/*.{js,coffee,em}"
templates = "app/templates/**/*.{hbs,handlebars,hjs,emblem}"
styles    = "app/styles/**/*.{css,sass,scss,less,styl}"
indexHTML = "app/index.html"
api       = "api/**/*.{js,coffee,em}"
other     = "{app,tests,public,vendor}/**/*"

module.exports =
  scripts:
    files: [scripts]
    tasks: [
      "lock"
      "buildScripts"
      "unlock"
    ]

  templates:
    files: [templates]
    tasks: [
      "lock"
      "buildTemplates:debug"
      "unlock"
    ]

  styles:
    files: [styles]
    tasks: [
      "lock"
      "buildStyles"
      "unlock"
    ]

  indexHTML:
    files: [indexHTML]
    tasks: [
      "lock"
      "buildIndexHTML:debug"
      "unlock"
    ]

  # api:
    # files: [api]
    # tasks: [
      # "lock"
      # "expressServer:debug"
      # "unlock"
    # ]
  
  other:
    files: [
      other
      "!" + scripts
      "!" + templates
      "!" + styles
      "!" + indexHTML
    ]
    tasks: [
      "lock"
      "build:debug"
      "unlock"
    ]

  options:
    
    # No need to debounce
    debounceDelay: 0
    
    # When we don't have inotify
    interval: 100
    livereload: Helpers.isPackageAvailable("connect-livereload")
