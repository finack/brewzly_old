# Works with tasks/locking.js
lockFile = require 'lockfile'

module.exports = ->
  _lock = (req, res, next) =>
    foo = @
    if lockFile.checkSync("tmp/connect.lock")
       setTimeout retry, 30
     else
       next()
