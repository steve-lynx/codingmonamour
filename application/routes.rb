# encoding: utf-8

class MainApplication < Sinatra::Base
 
  before do
    mtd = (request.path == '/') ? File.join(settings.views, 'index.yml') : File.join(settings.views, "#{request.path}.yml")
    @metadatas = settings.metadatas.merge( File.exist?(mtd) ? YAML.load_file(mtd).to_h : {})
  end

  get '/' do
    slim(:'layouts/main' , :locals => { :content => :index, :metadatas => @metadatas})
  end

  get '*' do     
    begin
      slim(:'layouts/main' , :locals => { :content => params['splat'].join('/').to_sym, :metadatas => @metadatas })
    rescue
      halt 404, slim(:'layouts/main' , :locals => { :content => :'errors/404', :metadatas => @metadatas })
    end
  end
  
end
