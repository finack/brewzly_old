module.exports = (grunt) ->

  Helpers  = require './helpers'
  express  = require 'express'
  request  = require 'request'
  static_  = require './middleware/static'
  lock     = require './middleware/lock'

  passThrough = (target) ->
    (req, res) ->
      req.pipe(request(target + req.url)).pipe res

  ###
  Task for serving the static files.
  
  Note: The expressServer:debug task looks for files in multiple directories.
  ###
  grunt.registerTask "expressServer", (target, proxyMethodToUse) ->
    require "express-namespace"
    done = @async()

    app = express()
    app.use lock()
    app.use express.compress()
    app.use express.bodyParser()

    emberPaths = [
      new RegExp("^/chronicle.*")
    ]
    
    proxyMethod = proxyMethodToUse or grunt.config("express-server.options.APIMethod")

    if proxyMethod is "stub"
      grunt.log.writeln "Using API Stub"
      app.use express.json()
      app.use express.urlencoded()
      require("../api/stubs") app
    else if proxyMethod is "proxy"
      proxyURL = grunt.config("express-server.options.proxyURL")
      grunt.log.writeln "Proxying API requests to: " + proxyURL
      app.all "/api/*", passThrough(proxyURL)
    else
      grunt.log.writeln 'Serving APIs directly'
      db = require '../api/db'
      db.setup()
      require('../api/routes') app, db

    if target is "debug"
      app.use require("connect-livereload")()  if Helpers.isPackageAvailable("connect-livereload")
      app.use static_(
        urlRoot: "/config"
        directory: "config"
      )
      app.use static_(
        urlRoot: "/vendor"
        directory: "vendor"
      )
      app.use static_(directory: "public")
      app.use static_(
        urlRoot: "/tests"
        directory: "tests"
      )
      app.use static_(
        urlRoot: "/fonts"
        directory: "vendor/bootstrap/dist/fonts"
      )
      app.use static_(directory: "tmp/result")
      app.use static_(file: "tmp/result/index.html", paths: emberPaths)
    else
      app.use lock()
      app.use static_(directory: "dist")
      app.use static_(
        urlRoot: "/fonts"
        directory: "dist/fonts"
      )
      app.use static_(file: "dist/index.html", paths: emberPaths)

    port = process.env.PORT or 8000
    app.listen port

    grunt.log.ok "Started development server on port %d.", port
    done() unless @flags.keepalive
