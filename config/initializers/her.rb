require "./lib/my_token_authentication"

Her::API.setup url: Rails.application.config.rest_api_url do |c|
  c.use APITokenAuthentication
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::DefaultParseJSON
  c.use Faraday::Adapter::NetHttp
end
