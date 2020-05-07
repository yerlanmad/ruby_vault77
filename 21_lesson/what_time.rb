require 'sinatra'

get '/london' do
  london_time = Time.now.utc
  "It's #{london_time} in London now"
end
