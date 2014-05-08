express = require 'express'
app = express()

app.get '/', (req, res) ->
  res.type 'application/json'
  res.send '{"result": "ok"}'

app.listen(process.env.PORT || 8080)