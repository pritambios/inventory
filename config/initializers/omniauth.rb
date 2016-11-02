Rails.application.config.middleware.use OmniAuth::Builder do
  secret_keys = Rails.application.secrets
  provider :google_oauth2,  secret_keys["client_id"],
                            secret_keys["client_secret"]
end
