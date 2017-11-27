# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )


Rails.application.config.action_controller.permit_all_parameters = true
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.sass.load_paths << File.expand_path('../../lib/assets/stylesheets/')
Rails.application.config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf character_sheets/* appStrap.js)
Rails.application.config.assets.precompile += %w( appStrap/plugins/jPanelMenu/jquery.jpanelmenu.min.js appStrap/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js)

