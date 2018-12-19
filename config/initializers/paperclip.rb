if Rails.env.production?
  Paperclip::Attachment.default_options.update(
    path:        ":class/:id_partition/:hash.:extension",
    hash_secret: "31f20b780e1e9dec2643bde2fca542ad2ba5140502ce091b364fd35f07168b38829aaeffe3ccfb853ce69f580480323cdf103a18ee092a0be1ec16abb425054b",
    convert_options: {
      all: "-interlace Plane -strip"
    },
    storage: :s3,
    s3_credentials: {
      bucket: Rails.application.secrets.bucket,
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_access_key_secret,
      s3_region: Rails.application.secrets.aws_region
    },
    s3_permissions: :private
  )
end
