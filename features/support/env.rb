# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../../../../config/environment')

require 'cucumber/rails/world'
require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
require 'webrat'
 
Webrat.configure do |config|
  config.mode = :rails
end
 
# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'dataset'
 
Cucumber::Rails::World.class_eval do
  include Dataset
  datasets_directory "#{RADIANT_ROOT}/spec/datasets"
  Dataset::Resolver.default << (File.dirname(__FILE__) + "/../../spec/datasets")
  self.datasets_database_dump_path = "#{Rails.root}/tmp/dataset"
  
  dataset :pages_with_layouts, :users, :page_attachments
end
