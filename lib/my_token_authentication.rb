class APITokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["api-auth-token"] = Rails.application.config.rest_api_auth_token
    @app.call(env)
  end
end
