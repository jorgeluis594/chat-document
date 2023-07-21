require 'omniauth-slack'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], scope: 'calls:read', redirect_uri: 'https://3d33-38-25-25-140.ngrok-free.app/auth/callback'
end