class AppointmentsController < ApplicationController
    get '/appointments' do 
        redirect_if_not_logged_in
        @appointments = appointment.all
        erb :index
    end 
    
    get '/appointments/new' do
        redirect_if_not_logged_in
        erb :new
    end

    post '/appointments' do
        redirect_if_not_logged_in
        @appointment = user.appointments.build(appointment_params)
        @appointment.user = User.find(session[:user_id])
        if @appointment.save
        erb :show
        else 
          appointment_params.nil? || appointment_params.empty?
          @errors = ["Please enter the correct information"]
          erb :failure
         end
    end

    get '/appointments/:id' do
      @appointment = appointment.find(params[:id])
      erb :show
    end

    get '/appointments/:id/edit' do
      redirect_if_not_logged_in 
       if user
      @appointment = user.appointments.find_by(id: params[:id])
      if @appointment
        erb :edit
       else 
        redirect '/'
       end
      else 
      redirect '/'
       end
    end
    
      patch '/appointments/:id' do
        redirect_if_not_logged_in  
        @appointment = user.appointments.find_by(id: params[:id])
        @appointment.user = params[:user]
        @appointment.grade = params[:grade]
        @appointment.save
        erb :show
    end

      delete '/appointments/:id' do
        redirect_if_not_logged_in 
       if user
         @appointment = user.appointments.find_by(id: params[:id])
        if @appointment
          @appointment.delete
          redirect '/profile'
       else 
        redirect '/'
       end
      else redirect '/'
       end

      end	
      
      private

      def appointment_params
        { appointment: params[:appointment], grade: params[:grade], user: params[:user]}
      end
end