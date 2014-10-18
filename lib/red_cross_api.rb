require 'red_cross_api/request'

module RedCrossAPI
  extend self

  class BaseError < StandardError; end
  class AuthorizationError < BaseError; end
  class AuthenticationError < BaseError; end

  def authentication(params)
    RedCrossAPI::Request.new.authentication(params)
  end

  def profile(token)
    RedCrossAPI::Request.new.profile(token)
  end
end
