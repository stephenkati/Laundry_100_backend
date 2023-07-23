class ApplicationController < ActionController::API
  def encoded_token(payload)
    JWT.encode(payload, 'secret')
  end
end
