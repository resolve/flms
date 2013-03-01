$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'flms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'flms'
  s.version     = Flms::VERSION
  s.authors     = ['Kevin Goslar']
  s.email       = ['kevin.goslar@originate.com']
  s.homepage    = 'TODO'
  s.summary     = 'Floating Layer Management System'
  s.description = 'A CMS for web pages that use interactive layers to present animated content.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 3.2.12'
  s.add_dependency 'cancan'
  s.add_dependency 'devise'
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'rspec-rails'
  #s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pg'
end
