_        = require('lodash')
r        = require("rethinkdb")
util     = require("util")
assert   = require("assert")
logdebug = require("debug")("rdb:debug")
logerror = require("debug")("rdb:error")

onConnect = (callback) ->
  r.connect
    host: dbConfig.host
    port: dbConfig.port
    authKey: dbConfig.authKey
  , (err, connection) ->
    assert.ok err is null, err
    connection["_id"] = Math.floor(Math.random() * 10001)
    callback err, connection

dbConfig =
  host: process.env.RETHINKDB_HOST or "localhost"
  port: parseInt(process.env.RETHINKDB_PORT) or 28015
  db: process.env.RETHINKDB_DB or "brewzly"
  authKey: process.env.RETHINKDB_AUTH or null
  tables:
    chronicles : "id"

module.exports.setup = ->
  r.connect
    host: dbConfig.host
    port: dbConfig.port
    authKey: dbConfig.authKey
  , (err, connection) ->
    assert.ok err is null, err
    r.dbCreate(dbConfig.db).run connection, (err, result) ->
      if err
        logdebug "[DEBUG] RethinkDB database '%s' already exists (%s:%s)\n%s", dbConfig.db, err.name, err.msg, err.message
      else
        logdebug "[INFO ] RethinkDB database '%s' created", dbConfig.db
      for tbl of dbConfig.tables
        ((tableName) ->
          r.db(dbConfig.db).tableCreate(tableName,
            primaryKey: dbConfig.tables[tbl]
          ).run connection, (err, result) ->
            if err
              logdebug "[DEBUG] RethinkDB table '%s' already exists (%s:%s)\n%s", tableName, err.name, err.msg, err.message
            else
              logdebug "[INFO ] RethinkDB table '%s' created", tableName
        ) tbl
    connection.close()

module.exports.findChronicle = (id, callback) ->
  onConnect (err, connection) ->
    logdebug "[INFO ][%s][findChronicles] chronicle %j", connection["_id"], id
    r.db(dbConfig.db).table('chronicles').get(id).run connection, (err, chronicle) ->
      if err
        logerror "[ERROR][%s][findChronicles][collect] %s:%s\n%s", connection["_id"], err.name, err.msg, err.message
        callback err
      else
        callback null, chronicle
      connection.close()

module.exports.findChronicles = (callback) ->
  onConnect (err, connection) ->
    logdebug "[INFO ][%s][findChronicles] All Chronicles", connection["_id"]
    r.db(dbConfig.db).table('chronicles').run connection, (err, cursor) ->
      if err
        logerror "[ERROR][%s][findChronicles][collect] %s:%s\n%s", connection["_id"], err.name, err.msg, err.message
        callback err
      else
        cursor.toArray (err, result) ->
          if err
            logerror "[ERROR][%s][findChronicles][collect] %s:%s\n%s", connection["_id"], err.name, err.msg, err.message
            callback err
          else
            callback null, result
      connection.close()

module.exports.saveChronicle = (chronicle, callback) ->
  chronicle.brewedAt = new Date(chronicle.brewedAt) if chronicle.brewedAt
  chronicle.updatedAt = new Date
  onConnect (err, connection) ->
    r.db(dbConfig.db).table('chronicles').insert(chronicle).run connection, (err, result) ->
      unless err is null
        logerror "[ERROR][%s][saveChronicle] %s:%s\n%s", connection["_id"], err.name, err.msg, err.message
        callback err
      else
        if result.inserted is 1
          callback null, _.merge(chronicle, { "id" : result.generated_keys.pop() })
        else
          callback null, false
    connection.close()

module.exports.deleteChronicle = (id, callback) ->
  onConnect (err, connection) ->
    r.db(dbConfig.db).table('chronicles').get(id).delete().run connection, (err, result) ->
      unless err is null
        logerror "[ERROR][%s][deleteChronicle] %s:%s\n%s", connection["_id"], err.name, err.msg, err.message
        callback err, null
      else
        if result.deleted is 1
          callback null, true
        else
          throw "Database deleted multiple values"
          callback null, false
    connection.close()
