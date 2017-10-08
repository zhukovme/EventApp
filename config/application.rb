require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SmileExpo
  class Application < Rails::Application

    config.load_defaults 5.1

    config.action_controller.permit_all_parameters = true

    config.autoload_paths += %W(#{config.root}/app/validators)

  end
end
