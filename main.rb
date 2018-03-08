require 'pg'
require 'rack'


postgres = PG.connect(dbname: 'postgres')
begin
  postgres.exec("CREATE DATABASE shopapi")

rescue PG::Error => e
  p "DB already initialized"
end

conn = PG.connect(dbname: "shopapi")


p conn.server_version



app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = "text/text"
  res.write(req.path)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 4000
)
