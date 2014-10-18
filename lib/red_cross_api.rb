require 'red_cross_api/request'

module RedCrossAPI
  extend self

  class AuthenticationError < StandardError; end

  def authentication(params)
    RedCrossAPI::Request.new.authentication(params)
  end
end
