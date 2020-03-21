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
        redirect_if_not_logged_in
        @appointment = Appointment.new(appointment_params)
        # binding.pry
        #@appointment.user_id = User.find(session[:user_id])
        if @appointment.save
        redirect "/appointments/#{@appointment.id}"
        else 
          appointment_params.nil? || appointment_params.empty?
          @errors = ["Please enter the correct information"]
          erb :failure
         end
    end

    get '/appointments/:id' do
      @appointment = Appointment.find(params[:id])
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
        @appointment.subject = params[:subject]
        @appointment.content = params[:content]
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
        { user_id: session[:user_id], grade: params[:grade], appointment_time: params[:appointment_time], subject: params[:subject], content: params[:content]}
      end
end