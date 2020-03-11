class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :time 
      t.integer :user_id
      t.integer :grade
      t.string :subject
      t.string :content
    end
  end
end 
