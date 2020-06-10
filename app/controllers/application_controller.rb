require './config/environment'
require 'sinatra/flash'

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
    #logged_in_user_id = session[:user_id]
    #@user = User.find_by(id: logged_in_user_id)
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id] #double bang operator -> makes it a boolean type(! operator twice) is someone there or not there?
    end
  end

  def current_user
    if is_logged_in?
      User.find(session[:user_id])
    end
  end
end