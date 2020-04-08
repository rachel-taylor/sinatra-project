class UsersController < ApplicationController
    get '/signup' do 
        erb :"/user/signup" 
    end 
    
    post '/signup' do
      @user = User.new(user_params)
      #binding.pry 
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        @errors = ["Please enter valid information to signup!"]
        erb :failure
      end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        @user = User.find(params[:id])  
        erb :"/user/profile"
    end

    get '/login' do 
        erb :login 
    end 

    post '/login' do 
        @user = User.find_by(username: params[:username])
        # binding.pry
        if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
        else 
        @errors = ["Please enter valid information to Login your account!"]  
        erb :failure
        end
    end 

    get '/profile' do 
      @user = User.find(session[:user_id]) 
      # binding.pry 
      erb :"/user/profile"
    end 

    get '/signout' do 
        redirect_if_not_logged_in
        session.clear 
        redirect '/'
    end
   
    private 
    def user_params
      { username: params[:username], password: params[:password] }
    end
    
end 