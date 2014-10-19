require 'json'
require 'ostruct'

class BadgesController < ApplicationController
  attr_reader :user
  helper_method :user

  def show
    @user = User.find_by!(:key => params[:key])
    expire_fragment(user.badge_cache_key) if params[:refresh] == '1'

    # This is meant to be displayed through an iframe
    render :layout => false
    allow_iframe
  end

  def blood_profile
    @blood_profile ||= BloodProfile.new RedCrossAPI.profile(user.token)
  end
  helper_method :blood_profile
end
