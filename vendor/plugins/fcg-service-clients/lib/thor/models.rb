require 'thor'
require 'thor/group'
require "active_support/all"
class CreateModel < Thor::Group
  include Thor::Actions
  
  argument :name
  class_option :client_class, :default => nil
  
  desc "Generate model file for FCG Service Client"
  
  def self.source_root
    @_source_root ||= File.join(File.dirname(__FILE__), "../../", "generators", "models")
  end
  
  def client_class
    @client_class ||= if options[:client_class]
      options[:client_class]
    else
      "FCG::Client::#{klass}"
    end
  end
  
  def version
    "v#{options[:version_number]}"
  end
  
  def model
    @model ||= name.downcase.singularize
  end
  
  def model_pluralize
    @model_pluralize ||= model.pluralize
  end
  
  def klass
    @klass ||= model.classify
  end
  
  def create_model_file
    template('model.tt', "app/models/#{model}.rb")
  end
end