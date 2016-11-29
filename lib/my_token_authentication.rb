class MyTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["api_auth_token"] = '66a17e730370115d890d0bd31467edd555'
    @app.call(env)
  end
end
