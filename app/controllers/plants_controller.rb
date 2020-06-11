class PlantsController < ApplicationController
    #Read the plants, show (index) every instance
      get '/plants' do
        if is_logged_in?
          @user = current_user
          @plants = @user.plants.all
          erb :'plants/index'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/users/login'
        end
      end
    #Show form to create a new instance of a plant.
      get '/plants/new' do
        if is_logged_in?
          erb :'plants/new'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to 'users/login'
        end
      end
    #Process the form and create a plant object in DB.
      post '/plants' do
        if params[:name] == "" || 
           params[:num_water_day] == "" || 
           params[:num_fert_day] == "" || 
           params[:num_prune_day] == ""
           flash[:message] = "Oops! PLants must have a name, water day, fertilizer day and prune day. Please try again."
           redirect to '/plants/new'
        else
          @user = current_user
          @plant = Plant.create(
            :name => params[:name],
            :num_water_day => params[:num_water_day],
            :num_fert_day => params[:num_fert_day],
            :num_prune_day => params[:num_prune_day]
          )
            redirect to "/plants/#{@plant.id}" #redirects t
        end
      end
    #READ:GET action show that view page to show that particular plant
      #get '/plants/:id' do
      #  if is_logged_in?
      #  @plant = Plant.find_by_id(params[:id])
      #  @user
      #  erb :'/plants/show'
      #end
    #Render all of the plants
      get '/plants/index' do
        @plants = Plant.all #returns an array
        erb :'plants/index'
      end
      #update
      get '/plants/:id/edit' do
        @plant = Plant.find(params[:id])
        erb :'/plants/edit'
      end
    
      patch '/plants/:id' do
        @plant = Plant.find(params[:id])
        @plant.update(
          :name => params[:name],
          :num_water_day => params[:num_water_day],
          :num_fert_day => params[:num_fert_day],
          :num_prune_day => params[:num_prune_day],
          :user_id => params[:user_id]
        )
        redirect "/plants/#{@plant.id}"
      end
    #Delete
      delete '/plants/:id/delete' do
        if is_logged_in?
          @plant = Plant.find_by_id(params[:id])
          @plant.user_id == session[:user_id]
          @plant.delete
          flash[:message] = "The plant was deleted."
          redirect to '/plants'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/login'
        end
      end
    end