Helpers  = require '../tasks/helpers.coffee'
express  = require 'express'
request  = require 'request'
static_  = require '../tasks/middleware/static'
db       = require '../api/db'

require "express-namespace"
exports.app = app = express()
require('../api/routes') app, db

app.use express.bodyParser()

emberPaths = [
  new RegExp("^/chronicle.*")
]

db.setup()

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
app.use static_(file: "dist/index.html", paths: emberPaths)

port = process.env.PORT or 8000
