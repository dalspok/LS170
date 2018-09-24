require 'sinatra'
require 'sinatra/reloader'

get "/" do
  @files = Dir.glob("public/*").map do |file|
    File.basename(file)
  end
  erb :home
end

get "/asc" do
  @files = Dir.glob("public/*").map do |file|
    File.basename(file)
  end.sort
  erb :home
end

get "/des" do
  @files = Dir.glob("public/*").map do |file|
    File.basename(file)
  end.sort {|a,b| b <=> a}
  erb :home
end