# encoding: utf-8

ROOT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__), ".."))
APP_FOLDER = File.join(ROOT_FOLDER, 'application')
HELPERS_FOLDER = File.join(APP_FOLDER, 'helpers')
LIB_FOLDER = File.join(ROOT_FOLDER, 'lib')
CONFIG_FOLDER = File.join(ROOT_FOLDER, 'config')
  
[  
  LIB_FOLDER, 
  CONFIG_FOLDER,
  APP_FOLDER
].each {|path|
  $LOAD_PATH << path unless $LOAD_PATH.include?(path)
}

require 'sinatra'
require 'sinatra/base'
require 'slim'
require 'yaml'

class MainApplication < Sinatra::Base

set :environment, :development
set :logging, true
set :static, true
set :root, ROOT_FOLDER
set :application, APP_FOLDER
set :libraries, LIB_FOLDER
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "documents") }

set :metadatas, Proc.new { YAML.load_file(File.join(application, 'metadata.yml')).to_h  }
set :doc_metadatas, Proc.new { |doc| YAML.load_file(File.join(views, doc)).to_h  }

set :server, %w[thin webrick]
set :bind, '0.0.0.0'
set :port, 3000

set :slim, :pretty => true
#set :slim, :disable_escape => true
set :slim, :format => :html
set :markdown, :layout_options => { :views => File.join(settings.views, "layouts") }
set :markdown, :layout_engine => :slim
set :markdown, :input => 'GFM'

Dir[File.join(APP_FOLDER, '*.rb')].each { |h| require(h) }

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  Dir[File.join(HELPERS_FOLDER, '*.rb')].each { |h|
    require h 
    include eval(File.basename(h)[0..-4].capitalize) 
  }
end

run! if app_file == $0
end






