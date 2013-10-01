require 'carrierwave'

# Load S3 credentials from s3.yml if we are in dev, otherwise use environment:
unless Rails.env.test? or Rails.env.cucumber? or Rails.env.development?
  raise "Need to set S3_BUCKET, S3_ACCESS_KEY, and S3_SECRET_KEY in environment." if ENV['S3_BUCKET'] == nil || ENV['S3_ACCESS_KEY'] == nil || ENV['S3_SECRET_KEY'] == nil
end

if Rails.env.production?
  unless File.exists? "#{Rails.root}/config/s3.yml" or 
    print %Q(
             ERROR: NO config/s3.yml FOUND!
           
             FLMS relies on having Amazon S3 credentials to function correctly. Here is an example s3.yml file:
             "
             development:
               bucket: YOUR_BUCKET_ID
               access_key_id: YOUR_KEY_ID
               secret_access_key: YOUR_SECRET_ACCESS_KEY
               cdn_host: CDN_HOST *optional

             test:
               bucket: YOUR_BUCKET_ID
               access_key_id: YOUR_KEY_ID
               secret_access_key: YOUR_SECRET_ACCESS_KEY
               cdn_host: CDN_HOST *optional

             production:
               bucket: YOUR_BUCKET_ID
               access_key_id: YOUR_KEY_ID
               secret_access_key: YOUR_SECRET_ACCESS_KEY
               cdn_host: CDN_HOST *optional
               "

             FLMS has created an example S3 file with these contents at 'config/s3.yml.example'.
             
             For local development the filesystem is used instead of s3 but the file still must exist.
             )
             puts "\n"
  end
end

if Rails.env.development?
  s3_config = YAML.load_file "#{Rails.root}/config/s3.yml"
  S3_CREDENTIALS = { bucket: s3_config[Rails.env]['bucket'],
                     access_key_id: s3_config[Rails.env]['access_key_id'],
                     secret_access_key: s3_config[Rails.env]['secret_access_key'],
                     cdn_host: s3_config[Rails.env]['cdn_host']
                   }
else
  S3_CREDENTIALS = { bucket: ENV['S3_BUCKET'],
                     access_key_id: ENV['S3_ACCESS_KEY'],
                     secret_access_key: ENV['S3_SECRET_KEY'],
                     cdn_host: ENV['S3_CDN_HOST'] }
end


CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.root = Rails.root

  # Store uploads locally if in test, otherwise to S3:
  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/public"
  else
    config.storage = :fog
    config.fog_credentials = { :provider               => 'AWS',
                               :aws_access_key_id      => S3_CREDENTIALS[:access_key_id],
                               :aws_secret_access_key  => S3_CREDENTIALS[:secret_access_key],
                               :region                 => 'us-west-1',
                               :host                   => 's3.amazonaws.com' }
    config.fog_directory  = S3_CREDENTIALS[:bucket]
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
    config.asset_host = S3_CREDENTIALS[:cdn_host] if S3_CREDENTIALS[:cdn_host]
  end
end
