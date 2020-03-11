class ApplicationController < Sinatra::Base
  configure do 
      set :views, 'app/views'
      set :public_folder, 'public/bootstrap-4.4.1-dist'
      enable :sessions
      set :session_secret, "password_security"
  end
  get '/' do 
      erb :index
  end 

  get '/failure' do
      erb :failure 
  end 
  
helpers do
  def logged_in?
    !!session[:user_id]
  end
  def redirect_if_not_logged_in
      unless logged_in?
        redirect '/login'
      end
  end

  def appointments
    User.find(session[:User_id])
  end
end    
end 