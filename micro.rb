require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
set :sessions, true
enable :sessions
use Rack::Flash, :sweep => true

set :database, 'sqlite3:microdb.sqlite3'

set :sessions, true

require './models'

get '/' do 
	"Welcome!<br>
	Please <a href='/sign-in'>click here</a> to sign in<br>
	Not a member? <a href='/join'>Click here</a> to create an account"
end

get '/join' do
	erb :join
end

post '/join' do
	@user = User.new(params[:user])
	if @user.save
		flash[:notice] = "Success! Please <a href='/sign-in'>click here</a> to sign in."
	else
		flash[:alert] = "There was a problem creating your account"
	end
end

get '/sign-in' do
	erb :sign_in
end

post '/sign-in' do
	puts params.inspect
	@user = User.where(username: params[:username]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		redirect '/profile'
	else
		flash[:alert] = "there was a problem logging you in"
	end
end

get '/profile' do
	@user = User.find(session[:user_id])
	erb :profile
end

post '/userprofile' do
	puts params.inspect
	@user = User.find(session[:user_id])
	@post = Post.new(params[:post])
end

get '/userprofile' do
	@user = User.find(session[:user_id])
	@posts = Posts.where(:user_id => @user.id)
end





