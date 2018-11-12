require 'dragonfly'

# Configure
Dragonfly.app(:engine).configure do
  plugin :imagemagick,
    convert_command:  `which convert`.strip.presence || '/usr/local/bin/convert',
    identify_command: `which identify`.strip.presence || '/usr/local/bin/identify'

  processor :thumb, Locomotive::Dragonfly::Processors::SmartThumb.new

  verify_urls true

  secret '2363e3eed19a5dcf28c87bf24140e2f96bc9ef0f9b98dc7255d514795309d310'

  url_format '/images/dynamic/:job/:sha/:basename.:ext'

  fetch_file_whitelist /public/

  fetch_url_whitelist /.+/
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware, :engine
