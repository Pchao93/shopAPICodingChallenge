require 'pg'
require 'rack'

postgres = PG.connect(dbname: 'postgres')
postgres.exec("CREATE DATABASE shopAPI")



app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = "text/text"
  res.write(req.path)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
