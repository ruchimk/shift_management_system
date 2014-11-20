# config/initializers/paperclip.rb
Paperclip::Attachment.default_options.merge!({
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
# config.paperclip_defaults = {
#   storage: :s3,
#   s3_credentials: {
#     :access_key_id => 'AKIAI27H6KM4IGJ7AWKQ',
#     :secret_access_key => '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',
#     :bucket => 'shiftable'
#   }
# }

  # s3_host_name: 's3-us-west-1.amazonaws.com',
