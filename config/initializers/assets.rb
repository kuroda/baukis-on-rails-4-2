Rails.application.config.assets.precompile +=
  %w( staff.css admin.css customer.css staff.js admin.js customer.js )

Sprockets::Context.send(:include, Rails.application.routes.url_helpers)
