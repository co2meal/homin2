

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '564601136972268', 'eb9e4316f93591933ca6df480518c413',:client_options=> {:ssl=> {:ca_path=>'C:\\RailsInstaller'}}
end

