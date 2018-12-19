Aws.config.update({
  access_key_id: Rails.application.secrets.aws_access_key_id,
  secret_access_key: Rails.application.secrets.aws_access_key_secret,
  region: Rails.application.secrets.aws_region
})
