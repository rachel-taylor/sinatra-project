class AppointmentsController < ApplicationController
    get '/appointments' do 
        redirect_if_not_logged_in
        @appointments = current_user.appointments
        erb :'/appointments/index'
    end 
    
    get '/appointments/new' do
        redirect_if_not_logged_in
        erb :'/appointments/new'
    end

    post '/appointments' do
      redirect_if_not_logged_in
        @appointment = current_user.appointments.build(params)
        if @appointment.save
        redirect "/appointments/#{@appointment.id}"
        else 
          @errors = ["Please enter the correct information"]
          erb :failure
         end
    end

    get '/appointments/:id' do
      @appointment = Appointment.find(params[:id])
      erb :'/appointments/show'
    end

    get '/appointments/:id/edit' do
      redirect_if_not_logged_in 
      @appointment = current_user.appointments.find_by(id: params[:id])
      if @appointment
        erb :'/appointments/edit'
      else 
      redirect '/'
       end
    end
    
      patch '/appointments/:id' do
        redirect_if_not_logged_in  
        if @appointment = current_user.appointments.find_by(id: params[:id])
        # @appointment.user = params[:user]
        @appointment.grade = params[:grade]
        @appointment.subject = params[:subject]
        @appointment.content = params[:content]
        @appointment.save
        erb :'/appointments/show'
        else redirect '/'
        end 
    end

    delete '/appointments/:id' do
      @appointment = Appointment.find(params[:id])
      @appointment.delete
      redirect '/profile'
    end

      
      private

      def appointment_params
        { user_id: session[:user_id], grade: params[:grade], appointment_time: params[:appointment_time], subject: params[:subject], content: params[:content]}
      end
end 