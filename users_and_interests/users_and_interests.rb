require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"


before do
  @users = Psych.load_file("data/users.yaml")
  @user_names = @users.keys
end


get "/" do
  erb :home
end

get "/:name" do
  user = params[:name].to_sym
  redirect "/" unless @user_names.include? user
  @user = @users[user]
  erb :user
end

helpers do
  def count_interests
    @users.reduce(0) do |memo, (_, user)|
      memo + user[:interests].size
    end
  end
end