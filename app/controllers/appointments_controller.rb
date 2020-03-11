class AppointmentsController < ApplicationController
    get '/appointments' do 
        redirect_if_not_logged_in
        @appointments = Appointment.all
        erb :'/appointments/index'
    end 
    
    get '/appointments/new' do
        redirect_if_not_logged_in
        erb :'/appointments/new'
    end

    post '/appointments' do
      # binding.pry
        redirect_if_not_logged_in
        @appointment = Appointment.new(appointment_params)
        # @appointment.user_id = User.find(session[:user_id])
        if @appointment.save
          binding.pry
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
        { user_id: session[:user_id], grade: params[:grade], time: params[:time], subject: params[:subject], content: params[:content]}
      end
end