require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module EventsApp
  class Application < Rails::Application

    config.load_defaults 5.1

    config.action_controller.permit_all_parameters = true

    config.autoload_paths += Dir[Rails.root.join('app', 'validators', '{**}')]

  end
end
