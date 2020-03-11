require './config/environment'

require_relative 'app/controllers/application_controller.rb'
require_relative 'app/controllers/appointments_controller.rb'
require_relative 'app/controllers/users_controller.rb'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use AppointmentsController
use UsersController 
run ApplicationController