module.exports = (grunt) ->
  
  # To support Coffeescript, SASS, LESS and others, just install
  # the appropriate grunt package and it will be automatically included
  # in the build process:
  #
  # * for Coffeescript, run `npm install --save-dev grunt-contrib-coffee`
  #
  # * for SCSS (without SASS), run `npm install --save-dev grunt-sass`
  # * for SCSS/SASS support (may be slower), run
  #   `npm install --save-dev grunt-contrib-sass`
  #   This depends on the ruby sass gem, which can be installed with
  #   `gem install sass`
  # * for Compass, run `npm install --save-dev grunt-contrib-compass`
  #   This depends on the ruby compass gem, which can be installed with
  #   `gem install compass`
  #   You should not install SASS if you have installed Compass.
  #
  # * for LESS, run `npm install --save-dev grunt-contrib-less`
  #
  # * for Stylus/Nib, `npm install --save-dev grunt-contrib-stylus`
  #
  # * for Emblem, run the following commands:
  #   `npm uninstall --save-dev grunt-ember-templates`
  #   `npm install --save-dev grunt-emblem`
  #   `bower install emblem.js --save`
  #
  # * For EmberScript, run `npm install --save-dev grunt-ember-script`
  #
  # * for LiveReload, `npm install --save-dev connect-livereload`
  #
  # * for displaying the execution time of the grunt tasks,
  #   `npm install --save-dev time-grunt`
  #
  # * for minimizing the index.html at the end of the dist task
  #   `npm install --save-dev grunt-contrib-htmlmin`
  #
  # * for minimizing images in the dist task
  #   `npm install --save-dev grunt-contrib-imagemin`
  #
  Helpers = require("./tasks/helpers")

  filterAvailable = Helpers.filterAvailableTasks
  _ = grunt.util._
  path = require("path")
  Helpers.pkg = require("./package.json")
  require("time-grunt") grunt  if Helpers.isPackageAvailable("time-grunt")
  
  # Loads task options from `tasks/options/`
  # and loads tasks defined in `package.json`
  config = require("load-grunt-config")(grunt,
    defaultPath: path.join(__dirname, "tasks/options")
    configPath: path.join(__dirname, "tasks/custom")
    init: false
  )
  grunt.loadTasks "tasks" # Loads tasks in `tasks/` folder
  config.env = process.env
  
  # Main Tasks
  # ==========
  
  # Generate the production version
  # ------------------
  grunt.registerTask "dist", "Build a minified & production-ready version of your app.", [
    "clean:dist"
    "build:dist"
    "copy:assemble"
    "createDistVersion"
  ]
  
  # Default Task
  # ------------------
  grunt.registerTask "default", "Build (in debug mode) & test your application.", ["test"]
  
  # Servers
  # -------------------
  grunt.registerTask "server", "Run your server in development mode, auto-rebuilding when files change.", (proxyMethod) ->
    expressServerTask = "expressServer:debug"
    expressServerTask += ":" + proxyMethod  if proxyMethod
    grunt.task.run [
      "clean:debug"
      "build:debug"
      expressServerTask
      "watch"
    ]

  grunt.registerTask "server:dist", "Build and preview a minified & production-ready version of your app.", [
    "dist"
    "expressServer:dist:keepalive"
  ]
  
  # Testing
  # -------
  grunt.registerTask "test", "Run your apps's tests once. Uses Google Chrome by default. Logs coverage output to tmp/result/coverage.", [
    "clean:debug"
    "build:debug"
    "karma:test"
  ]
  grunt.registerTask "test:ci", "Run your app's tests in PhantomJS. For use in continuous integration (i.e. Travis CI).", [
    "clean:debug"
    "build:debug"
    "karma:ci"
  ]
  grunt.registerTask "test:browsers", "Run your app's tests in multiple browsers (see tasks/options/karma.js for configuration).", [
    "clean:debug"
    "build:debug"
    "karma:browsers"
  ]
  grunt.registerTask "test:server", "Start a Karma test server and the standard development server.", (proxyMethod) ->
    expressServerTask = "expressServer:debug"
    expressServerTask += ":" + proxyMethod  if proxyMethod
    grunt.task.run [
      "clean:debug"
      "build:debug"
      "karma:server"
      expressServerTask
      "addKarmaToWatchTask"
      "watch"
    ]

  
  # Worker tasks
  # =================================
  grunt.registerTask "build:dist", [
    "createResultDirectory" # Create directoy beforehand, fixes race condition
    "concurrent:buildDist" # Executed in parallel, see config below
  ]
  grunt.registerTask "build:debug", [
    "jshint:tooling"
    "createResultDirectory" # Create directoy beforehand, fixes race condition
    "concurrent:buildDebug" # Executed in parallel, see config below
  ]
  grunt.registerTask "createDistVersion", filterAvailable([
    "useminPrepare" # Configures concat, cssmin and uglify
    "concat"        # Combines css and javascript files
    "cssmin"        # Minifies css
    "uglify"        # Minifies javascript
    "imagemin"      # Optimizes image compression
    # 'svgmin',
    "copy:dist"     # Copies files not covered by concat and imagemin
    "rev"           # Appends 8 char hash value to filenames
    "usemin"        # Replaces file references
    "htmlmin:dist"  # Removes comments and whitespace
  ])
  
  # Parallelize most of the build process
  _.merge config,
    concurrent:
      buildDist: [
        "buildTemplates:dist"
        "buildScripts"
        "buildStyles"
        "buildIndexHTML:dist"
      ]
      buildDebug: [
        "buildTemplates:debug"
        "buildScripts"
        "buildStyles"
        "buildIndexHTML:debug"
      ]
  
  # Templates
  grunt.registerTask "buildTemplates:dist", filterAvailable([
    "emblem:compile"
    "emberTemplates:dist"
  ])
  grunt.registerTask "buildTemplates:debug", filterAvailable([
    "emblem:compile"
    "emberTemplates:debug"
  ])
  
  # Scripts
  grunt.registerTask "buildScripts", filterAvailable([
    "jshint:app"
    "jshint:tests"
    "coffee"
    "emberscript"
    "copy:javascriptToTmp"
    "transpile"
    "concat_sourcemap"
  ])
  
  # Styles
  grunt.registerTask "buildStyles", filterAvailable([
    "compass:compile"
    "sass:compile"
    "less:compile"
    "stylus:compile"
    "copy:cssToResult"
  ])
  
  # ToDo: Add 'autoprefixer'
  
  # Index HTML
  grunt.registerTask "buildIndexHTML:dist", [
    "preprocess:indexHTMLDistApp"
    "preprocess:indexHTMLDistTests"
  ]
  grunt.registerTask "buildIndexHTML:debug", [
    "preprocess:indexHTMLDebugApp"
    "preprocess:indexHTMLDebugTests"
  ]
  
  # Appends `karma:server:run` to every watch target's tasks array
  grunt.registerTask "addKarmaToWatchTask", ->
    _.forIn grunt.config("watch"), (config, key) ->
      return  if key is "options"
      config.tasks.push "karma:server:run"
      grunt.config "watch." + key, config

  grunt.registerTask "createResultDirectory", ->
    grunt.file.mkdir "tmp/result"

  grunt.initConfig config
