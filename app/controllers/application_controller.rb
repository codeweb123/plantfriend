require './config/environment'
require 'sinatra'
require 'sinatra/flash'
require 'date'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #network requests, make a session id and store it-session hash
    set :session_secret, 'planty123plant'
    register Sinatra::Flash
  end
#Homepage
  get "/" do
    @plants = Plant.all
    @locations = Location.all
    erb :'/index'
  end

  helpers do

  def logged_in?
    !!current_user #double bang operator -> makes it a boolean type(! operator twice) is someone there or not there?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
end
  
  #def current_user
   # if is_logged_in?
    #  User.find(session[:user_id])