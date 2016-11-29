require "./lib/my_token_authentication"

Her::API.setup url: "http://192.168.1.20:3001/api/" do |c|
  c.use MyTokenAuthentication
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::DefaultParseJSON
  c.use Faraday::Adapter::NetHttp
end
