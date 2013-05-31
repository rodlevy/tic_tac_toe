get '/' do
  erb :index
end

post '/game/square' do
content_type :json
{:data => true }.to_json
end
