# encoding: utf-8
################################################################################
## Initial developer: Massimo Maria Ghisalberti <massimo.ghisalberti@gmail.org>
## Date: 2016-12-18
## Company: Pragmas <contact.info@pragmas.org>
## Licence: Apache License Version 2.0, http://www.apache.org/licenses/
################################################################################

RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
ROOT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__), ".."))
APP_FOLDER = File.join(ROOT_FOLDER, 'application')
HELPERS_FOLDER = File.join(APP_FOLDER, 'helpers')
LIB_FOLDER = File.join(ROOT_FOLDER, 'lib')
CONFIG_FOLDER = File.join(ROOT_FOLDER, 'config')
DOC_FOLDER = File.join(ROOT_FOLDER, 'documents')
PUB_FOLDER = File.join(ROOT_FOLDER, 'public')

[  
  LIB_FOLDER, 
  CONFIG_FOLDER,
  APP_FOLDER
].each {|path|
  $LOAD_PATH << path unless $LOAD_PATH.include?(path)
}
Dir[File.join(LIB_FOLDER, '*.rb')].each { |h| require(h) }

require 'sinatra'
require 'sinatra/base'
require 'slim'
require 'yaml'

class MainApplication < Sinatra::Base  
  
  set :logging, true
  set :static, true
  set :root, ROOT_FOLDER
  set :application, APP_FOLDER
  set :libraries, LIB_FOLDER
  set :public_folder, PUB_FOLDER
  set :views, DOC_FOLDER

  set :metadatas, Proc.new { YAML.load_file(File.join(application, 'metadata.yml')).to_h  }
  set :doc_metadatas, Proc.new { |doc| YAML.load_file(File.join(views, doc)).to_h  }

  set :server, %w[thin webrick]
  set :bind, '0.0.0.0'
  set :port, 8080

  set :slim, :pretty => true
  set :slim, :format => :html
  #set :slim, :disable_escape => true
  #set :markdown, :layout_options => {:views => Proc.new { File.join(settings.views, "layouts") }}
  set :markdown, :layout_engine => :slim
  set :markdown, :input => 'GFM' 

  require 'sass/plugin/rack'
  use Sass::Plugin::Rack
  Sass::Plugin.options[:syntax] = :scss
  Sass::Plugin.options[:style] =  :nested
  Sass::Plugin.options[:template_location] = File.join(DOC_FOLDER, 'stylesheets')
  Sass::Plugin.options[:css_location] = File.join(PUB_FOLDER,'stylesheets')  
  Sass::Plugin.options[:cache_location] = File.join(ROOT_FOLDER, 'temp', 'sass-cache')   

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html

    Dir[File.join(HELPERS_FOLDER, '*.rb')].each { |h|
      require h 
      include eval(File.basename(h)[0..-4].capitalize) 
    }
  end

  configure :development do    
    set :port, 3000
    set :slim, :pretty => false
    Sass::Plugin.options[:style] = :compressed
  end

  puts "Running in #{settings.environment}"

  run! if app_file == $0
end

Dir[File.join(APP_FOLDER, '*.rb')].each { |h| require(h) }






