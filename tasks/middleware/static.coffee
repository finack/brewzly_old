fs   = require 'fs'
path = require 'path'

module.exports = (options) ->
  staticEAK = (req, res, next) ->

    if options.directory
      regex = new RegExp("^" + (options.urlRoot or ""))

      # URL must begin with urlRoot's value
      unless req.path.match(regex)
        next()
        return
      filePath = options.directory + req.path.replace(regex, "")
    else if options.file and options.paths
      for regex in options.paths when regex.test(req.path) is false
        next()
        return
      
      filePath = options.file
    else if options.file
      filePath = options.file
    else
      throw new Error("staticEAK() isn't properly configured!")

    fs.stat filePath, (err, stats) ->
      # Not a file, not a folder => can't handle it
      if err
        next()
        return

      # Is it a directory? If so, search for an index.html in it.
      filePath = path.join(filePath, "index.html") if stats.isDirectory()

      # Serve the file
      res.sendfile filePath, (err) ->
        if err
          next()
          return
        # grunt.verbose.ok "Served: " + filePath
