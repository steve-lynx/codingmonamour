# encoding: utf-8

ROOT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__), ".."))

[  
  File.join(ROOT_FOLDER, 'lib'), 
  File.join(ROOT_FOLDER, 'config'),
  File.join(ROOT_FOLDER, 'application')
].each {|path|
  $LOAD_PATH << path unless $LOAD_PATH.include?(path)
}

require 'sinatra'
require 'slim'

set :environment, :development
set :logging, true
set :static, true
set :root, ROOT_FOLDER
set :application, Proc.new { File.join(root, "application") }
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "documents") }

set :server, %w[thin webrick]
set :bind, '0.0.0.0'
set :port, 3000

set :slim, :pretty => true
set :markdown, :layout_options => { :views => File.join(settings.views, "layouts") }
set :markdown, :layout_engine => :slim
set :markdown, :input => 'GFM'

require 'main'


