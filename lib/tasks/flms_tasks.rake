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
end
