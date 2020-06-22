#all of the interactions having to do with users.
class UsersController < ApplicationController
    #show the form (prefix the route)
      get '/users/signup' do #route
          redirect to '/users/signup'
        end
      #Processing form and create new object
      post '/users/signup' do
        if  params[:username] == "" || #check if we have bad data
            params[:email] == "" || 
            params[:password] == ""
          flash[:message] = "In order to sign up account, you must have a username, email & password. Please try again."
          redirect to '/users/signup'
        elsif
          logged_in?
            flash[:message] = "You are already logged in."
            redirect to '/users/login' 
        else  
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])  
           if @user.save
            session[:user_id] = @user.id #store it inside an instance variable, (username:) is the name of the column and insert the params[:username] from the params
          #binding.pry  
          erb :'users/login'
        end
      end
      #Login
      get '/users/login' do
          erb :'/users/login'
        end
    #process form and create a new user object
      post '/users/login' do
        @user = User.find_by(username: params[:username])
        #binding.pry
        if @user && @user.authenticate(params[:password]) #def authenticate(string)-compares the string to the encrypted (salts & encrypts) password and returns either false or the instance of the user again(true) given by Bcrypt.
          session[:user_id] = @user.id 
          #binding.pry  #logs user in and sets session
          erb :'/locations/new' 
          #direct them to add a location
        else
          flash[:message] = "Your username or password were not correct. Please try again."
          redirect to "/users/login" 
        end
      end
      
      # Log out
      get '/users/logout' do
          session.clear
          redirect to '/'
      end
    end