class Appointment < ActiveRecord::Base 
    validates :grade, :appointment, :user, presence: true
    belongs_to :user
end 