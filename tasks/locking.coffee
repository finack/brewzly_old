lockFile = require("lockfile")
module.exports = (grunt) ->
  grunt.registerTask "lock", "Set semaphore for connect server to wait on.", ->
    grunt.file.mkdir "tmp"
    lockFile.lockSync "tmp/connect.lock"
    grunt.log.writeln "Locked - Development server won't answer incoming requests until App Kit is done updating."

  grunt.registerTask "unlock", "Release semaphore that connect server waits on.", ->
    lockFile.unlockSync "tmp/connect.lock"
    grunt.log.writeln "Unlocked - Development server now handles requests."

