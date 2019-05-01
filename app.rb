require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?


get "/" do
  "This is the index, helloo"
end
