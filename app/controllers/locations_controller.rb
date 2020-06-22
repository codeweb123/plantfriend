class LocationsController < ApplicationController
    #index/show
    get '/locations/index' do
      if logged_in?
        @user = current_user
        @locations = @user.locations.all
        erb :'/locations/index'
      else
        flash[:message] = "Looks like you weren't logged in yet. Please log in below."
        redirect to '/users/login'
      end
    end
    #Create
    get '/locations/new' do
      if logged_in?
        erb :"/locations/new"
      else
        flash[:message] = "Looks like you weren't logged in yet. Please log in below."
        redirect "/users/login"
      end  
    end
    #process form location and create a location object
    post '/locations' do
      @location = Location.create(
      name: params[:name],
      user_id: session[:user_id]
      )
      @location.save
      redirect "/plants/new"
      end
      #Show
    get '/locations/:id' do
      @location = Location.find_by_id(params[:id])
      erb :'/locations/show'
    end
    #Edit
    get 'locations/:id/edit' do #load edit form
      @location = Location.find_by_id(params[:id])
      erb :'/locations/edit'
    end
  
    patch '/articles/:id' do
      @location = Location.find_by_id(params[:id])
      @location.name = params[:name]
      @location.user_id = params[:user_id]
      @location.save
      redirect to "/locations/#{@location.id}"
    end

    delete '/locations/:id/delete' do
        if logged_in?
          @location = Location.find_by_id(params[:id])
          @location.user_id == session[:user_id]
          @location.delete
          flash[:message] = "The location was deleted."
          redirect to '/locations'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/login'
        end
    end
  end
  