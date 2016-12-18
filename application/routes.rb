# encoding: utf-8

class MainApplication < Sinatra::Base
  
  before do
    absolute_path = File.join(settings.views, request.path)
    rev_root = File.dirname(absolute_path)
    index = settings.metadatas.fetch2(['application','home','document'], 'index').to_sym  
    
    documents =
      if File.directory?(absolute_path)
        @request_root = request.path
        [File.join(absolute_path, "#{index}.markdown")]
      else
        @request_root = File.dirname(request.path)
        Dir[File.join(rev_root, '*.markdown')].reduce([]) { |acc, d|
          acc << d unless d.match(File.basename(request.path)).nil?
          acc
        }
      end

    @request_path, @request_meta =
      if documents.empty?
        ['/', File.join(settings.views, "#{index}.yml")]
      else
        req_path = documents.first.gsub(settings.views, '')[1..-1].gsub(/\.\w*$/, '')
        [req_path, File.join(settings.views, "#{req_path}.yml")]
      end
    @metadatas = settings.metadatas.merge( File.exist?(@request_meta) ? YAML.load_file(@request_meta).to_h : {})
  end

  get '/' do
    document = settings.metadatas.fetch2(['application','home','document'], 'index').to_sym 
    slim(:'layouts/main' , :locals => { :content => document, :metadatas => @metadatas})
  end

  get '*' do
    begin
      slim(:'layouts/main' , :locals => { :content => @request_path.to_sym, :metadatas => @metadatas })
    rescue
      halt 404, slim(:'layouts/main' , :locals => { :content => :'errors/404', :metadatas => @metadatas })
    end
  end
  
end
