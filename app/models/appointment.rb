class Appointment < ActiveRecord::Base 
    validates :appointment_time, :user, presence: true
    belongs_to :user
end 

#<%=appointment.date.strftime('%a, %b %d %Y')%>