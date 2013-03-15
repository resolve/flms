require 'carrierwave'

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.root = Rails.root
end
# if Rails.env.test? or Rails.env.cucumber?
#   CarrierWave.configure do |config|
#     config.storage = :file
#     config.enable_processing = false
#   end
# end
