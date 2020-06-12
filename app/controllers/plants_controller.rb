class PlantsController < ApplicationController
    #Read the plants, show (index) every instance
      get '/plants/index' do
        if is_logged_in?  
        @plants = Plant.all
          erb :'plants/index'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/users/login'
        end
      end
           
    #Show form to create a new instance of a plant.
      get '/plants/new' do
        if is_logged_in?
          erb :'/plants/new'
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
          @plant = Plant.create(
            :name => params[:name],
            :num_water_day => params[:num_water_day],
            :num_fert_day => params[:num_fert_day],
            :num_prune_day => params[:num_prune_day],
            :location_id => params[:location_id]
          )
          #binding.pry
            redirect to "/plants/index"
            #redirect to "/plants/#{@plant.id}" #redirects t
        end
    end

    #READ:GET action show that view page to show that particular plant
      get '/plants/:id' do
        if is_logged_in?
        @plant = Plant.find_by(id: params[:id])
        
        erb :'/plants/show'
      end
    end

      #edit / read
      get '/plants/:id/edit' do
        if is_logged_in?
        @plant = Plant.find_by(id: params[:id])
        
        erb :'/plants/edit'
      end
    end

    #use middleware (Rack::MethodOverride) to send put/patch/delete requests 
      put '/plants/:id' do
        @plant = Plant.find_by(id: params[:id])
        @plant.update(
          :name => params[:name],
          :num_water_day => params[:num_water_day],
          :num_fert_day => params[:num_fert_day],
          :num_prune_day => params[:num_prune_day],
          :location_id => params[:location_id]
        )
        redirect "/plants/#{@plant.id}"
      end
    #Delete
      delete '/plants/:id' do
        if is_logged_in?
          @plant = Plant.find_by(id: params[:id])
          @plant.destroy
          flash[:message] = "The plant was deleted."
          redirect to '/plants/index'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/login'
        end
      end
    end