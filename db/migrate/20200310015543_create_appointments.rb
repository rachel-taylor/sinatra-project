class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :time 
      t.integer :user_id
    end
  end
end 
