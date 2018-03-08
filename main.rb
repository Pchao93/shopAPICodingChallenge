require 'pg'
require 'rack'
require 'rack/lobster'

postgres = PG.connect(dbname: 'postgres')
begin
  postgres.exec("CREATE DATABASE shopAPI;")
rescue PG::Error => e

end

conn = PG.connect(dbname: "shopapi")

p conn



# app = Proc.new do |env|
#   req = Rack::Request.new(env)
#   res = Rack::Response.new
#   res['Content-Type'] = "text/text"
#   res.write(req.path)
#   res.finish
# end

app = Rack::Lobster.new

Rack::Server.start(
  app: app,
  Port: 4000
)

while session = server.accept
  request = session.gets
  puts request

  # 1
  method, full_path = request.split(' ')
  # 2
  path, query = full_path.split('?')

  # 3
  status, headers, body = app.call({
    'REQUEST_METHOD' => method,
    'PATH_INFO' => path,
    'QUERY_STRING' => query
  })

  session.print "HTTP/1.1 #{status}\r\n"
  headers.each do |key, value|
    session.print "#{key}: #{value}\r\n"
  end
  session.print "\r\n"
  body.each do |part|
    session.print part
  end
  session.close
end
