# frozen_string_literal: true

require_relative 'errors/attribute_errors'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validatable'
require_relative 'logable'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'

require_relative 'app'

App.new.menu
