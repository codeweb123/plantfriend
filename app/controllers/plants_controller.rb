class PlantsController < ApplicationController

    #(INDEX)Read the plants, show (index) every instance
      get '/plants' do
        if logged_in? 
          @user = current_user 
          @plants = Plant.all
          @locations = Location.all
          erb :'plants/index'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to '/users/login'
        end
      end
           
    #(NEW)Show form to create a new instance of a plant.
      get '/plants/new' do
        if logged_in?
          @user = current_user
          erb :'/plants/new'
        else
          flash[:message] = "Looks like you weren't logged in yet. Please log in below."
          redirect to 'users/login'
        end
      end

    #(CREATE)Process the form and create a plant object in DB.
      post '/plants' do
          @user = current_user
        if params[:name] == "" || 
           params[:num_water_day] == "" || 
           params[:num_fert_day] == "" || 
           params[:num_prune_day] == ""
           flash[:message] = "Oops! PLants must have a name, water day, fertilizer day and prune day. Please try again."
           redirect to '/plants/new'
        else
          @plant = Plant.new(
            :name => params[:name],
            :num_water_day => params[:num_water_day],
            :num_fert_day => params[:num_fert_day],
            :num_prune_day => params[:num_prune_day],
            :location_id => params[:location_id],
            :user_id => params[:user_id]
          )
          @plant.user_id = current_user.id
          @plant.save
          #binding.pry
            redirect to "/plants"
        end
    end

    #(SHOW)READ:GET action show that view page to show that particular plant
      get '/plants/:id' do
        #id = params[:id]
          @plant = Plant.find_by(id: params[:id])
          erb :'/plants/show'
      end

      #(EDIT) / read
      get '/plants/:id/edit' do
        if logged_in?
            @plant = Plant.find_by(id: params[:id])
        if @plant.user == current_user
            @user = current_user
            erb :'/plants/edit'
        end

    #(UPDATE) use middleware (Rack::MethodOverride) to send put/patch/delete requests 
      put '/plants/:id' do
        if  @plant = Plant.find_by(id: params[:id])
            @plant.update(
              :name => params[:name],
              :num_water_day => params[:num_water_day],
              :num_fert_day => params[:num_fert_day],
              :num_prune_day => params[:num_prune_day],
              :location_id => params[:location_id],
              :user_id => params[:user_id]
            )
            @plant.user = current_user
            @plant.save
        end
          redirect "/plants/#{@plant.id}"
      end

    #(DESTROY) a plant
      delete '/plants/:id' do
         if logged_in?
            @plant = Plant.find_by(id: params[:id])
            @plant.user == current_user
            @user = current_user
            @plant.destroy
            flash[:message] = "The plant was deleted."
            redirect to '/plants/index'
        else
            flash[:message] = "Looks like you weren't logged in yet. Please log in below."
            redirect to '/login'
        end
      end
    end