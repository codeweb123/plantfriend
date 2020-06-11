#all of the interactions having to do with users.
class UsersController < ApplicationController
    #show the form (prefix the route)
      get '/users/signup' do #route
          erb :'/users/signup'
        end
      #Processing form and create new object
      post '/users/signup' do
        @user = User.create(params)
        if is_logged_in?
          flash[:message] = "You are already logged in."
          redirect to '/users/login'
        elsif params[:username] == "" || #check if we have bad data
              params[:email] == "" || 
              params[:password] == ""
          flash[:message] = "In order to sign up account, you must have a username, email & a password. Please try again."
          redirect to '/users/signup'
        else
          @user                        #store it inside an instance variable, (username:) is the name of the column and insert the params[:username] from the params
          session[:user_id] = @user.id #creates a new key/value pair
          redirect to "/users/login"
        end
      end
      #Login
      get '/users/login' do
          erb :'/users/login'
        end
    #process form and create a new user object
      post '/users/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password]) #def authenticate(string)-compares the string to the encrypted (salts & encrypts) password and returns either false or the instance of the user again(true) given by Bcrypt.
          session[:user_id] = @user.id 
          #binding.pry  #logs user in and sets session
          redirect "/locations/new" 
          #direct them to add a location
        else
          flash[:message] = "Your username or password were not correct. Please try again."
          redirect "/users/login" 
        end
      end
      #show page using dynamic routes
      #get '/users/:id' do
      #    @user = User.find(params[:id])
      #    erb :'/users/show'
      #end 
      # Log out
      get '/users/logout' do
          session.clear
          redirect to '/'
      end
    end