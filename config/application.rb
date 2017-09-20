require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module CDB3
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.action_controller.permit_all_parameters = true
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .eot .woff .ttf)
    config.sass.load_paths << File.expand_path('../../lib/assets/stylesheets/')
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')
    config.assets.paths << Rails.root.join("vendor", "assets", "images")
    console do
        require "pry"
        config.console = Pry
    end
  end
end
