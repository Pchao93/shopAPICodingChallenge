require 'pg'
require 'rack'


postgres = PG.connect(dbname: 'postgres')
begin
  postgres.exec("CREATE DATABASE shopAPI")
rescue PG::Error => e

end

conn = PG.connect(dbname: "shopAPI")

p conn



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
