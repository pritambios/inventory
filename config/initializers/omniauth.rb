Rails.application.config.middleware.use OmniAuth::Builder do
  secret_keys = Rails.application.secrets
  provider :google_oauth2,  secret_keys["google_client_id"], secret_keys["google_client_secret"]
end
