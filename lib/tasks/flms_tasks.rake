require 'io/console'

namespace :flms do

  desc 'Creates a user account'
  task :create_user, [:email] => :environment do |t, args|

    # Check params.
    unless args.email
      puts "Error: parameter 'email' not provided."
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
end


