# encoding: utf-8

get '/' do
  markdown(:index, :layout => :main)
end

get '*' do     
  begin
    markdown(params['splat'].join('/').to_sym, :layout => :main)
  rescue
    halt 404, markdown(:'errors/404', :layout => :main)
  end
end
