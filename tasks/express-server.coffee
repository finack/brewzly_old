module.exports = (grunt) ->

  express = require("express")
  lockFile = require("lockfile")
  Helpers = require("./helpers")
  fs = require("fs")
  path = require("path")
  request = require("request")
  
  
  lock = (req, res, next) -> # Works with tasks/locking.js
    (retry = ->
      if lockFile.checkSync("tmp/connect.lock")
        setTimeout retry, 30
      else
        next()
    )()

  static_ = (options) ->
    (req, res, next) -> # Gotta catch 'em all (and serve index.html)
      filePath = ""
      if options.directory
        regex = new RegExp("^" + (options.urlRoot or ""))
        
        # URL must begin with urlRoot's value
        unless req.path.match(regex)
          next()
          return
        filePath = options.directory + req.path.replace(regex, "")
      else if options.file
        filePath = options.file
      else
        throw new Error("static() isn't properly configured!")
      fs.stat filePath, (err, stats) ->
        if err # Not a file, not a folder => can't handle it
          next()
          return
        
        # Is it a directory? If so, search for an index.html in it.
        filePath = path.join(filePath, "index.html")  if stats.isDirectory()
        
        # Serve the file
        res.sendfile filePath, (err) ->
          if err
            next()
            return
          grunt.verbose.ok "Served: " + filePath

  passThrough = (target) ->
    (req, res) ->
      req.pipe(request(target + req.url)).pipe res

  ###
  Task for serving the static files.
  
  Note: The expressServer:debug task looks for files in multiple directories.
  ###
  grunt.registerTask "expressServer", (target, proxyMethodToUse) ->
    require "express-namespace"
    app = express()
    done = @async()
    proxyMethod = proxyMethodToUse or grunt.config("express-server.options.APIMethod")
    app.use lock
    app.use express.compress()

    if proxyMethod is "stub"
      grunt.log.writeln "Using API Stub"
      app.use express.json()
      app.use express.urlencoded()
      require("../api-stub/routes") app
    else if proxyMethod is "proxy"
      proxyURL = grunt.config("express-server.options.proxyURL")
      grunt.log.writeln "Proxying API requests to: " + proxyURL
      app.all "/api/*", passThrough(proxyURL)

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
      app.use static_(directory: "tmp/result")
      app.use static_(file: "tmp/result/index.html")
    else
      app.use lock
      app.use static_(directory: "dist")
      app.use static_(file: "dist/index.html")

    port = process.env.PORT or 8000
    app.listen port

    grunt.log.ok "Started development server on port %d.", port
    done()  unless @flags.keepalive
