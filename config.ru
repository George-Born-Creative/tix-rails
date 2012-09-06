# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

map '/' do
  run Tix::Application
end

map '/resque' do
  # key in initializers/session_store.rb
  # secret in initializers/secret_token.rb
  # We're doing this so that the same cookie is used across 
  # Resque Web and the Rails App
  use Rack::Session::Cookie, :key => '_tix_session', 
    :secret => Tix::Application.config.secret_token

  # Typical warden setup but instead of having resque web handle
  # failure, we'll pass it off to the rails app so that devise
  # can take care of it.
  use Warden::Manager do |manager|
    manager.failure_app = Tix::Application
    manager.default_scope = Devise.default_scope
  end

  # what the heck is this??
  # run Tix::Resque
end