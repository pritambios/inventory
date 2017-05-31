module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "12345",
      info: {
        email: "paromitadgp@gmail.com",
        first_name: "paromita",
        last_name: "gorai"
      },
      credentials: {
        google_client_id: "12345",
        google_client_secret: "ABCD"
      }
    })
  end
end

