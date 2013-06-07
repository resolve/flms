require 'io/console'
namespace :flms do

  desc 'Creates a user account'
  task :create_user, [:email] => :environment do |t, args|

    # Check params.
    unless args.email
      puts "Error: parameter 'email' not provided."
      puts "usage: rake flms:create_user[YourEmailAddressHere@example.com]"
      exit
    end

    # Read the password from the command line.
    print "Please enter the password for the new user: "
    password = STDIN.noecho(&:gets).chomp
    puts

    # Get user.
    begin
      Flms::User.create! email: args.email, password: password, password_confirmation: password
    rescue => e
      puts "Error: user with email '#{args.email}' could not be created."
      puts e.message
    else
      puts "User #{args.email} created."
    end

  end

  desc 'Update layers in DB from video to embed layer naming'
  task :convert_video_to_embed => :environment do
      Flms::Layer.update_all("type = 'Flms::EmbedLayer'", "type = 'Flms::VideoLayer'")
  end
  
  namespace :generate do
    desc 'Generate FLMS views in app for additional modification'
    task :views do
      flms_view_dir = File.expand_path("../../../app/views/flms/*", __FILE__)
      unless Dir.exists?("app/views/flms")
        FileUtils.mkdir "app/views/flms"
        FileUtils.cp_r Dir[flms_view_dir], "app/views/flms/"
      end
    end
    
    desc "Generate FLMS assets in app for additional modification"
    task :assets do
      flms_assets_dir = File.expand_path("../../../app/assets/stylesheets/*",__FILE__)
      unless Dir.exists?("app/assets/stylesheets/flms")
        FileUtils.cp_r Dir[flms_assets_dir], "app/assets/stylesheets"
      end
    end
  end
  
  namespace :destroy do
    desc "Remove FLMS views from app"
    task :views do
      FileUtils.rm_rf "app/views/flms"
    end
    
    desc "Remove FLMS assets from app"
    task :assets do
      FileUtils.rm_rf "app/assets/stylesheets/flms"
    end
  end
end
