class ProfileController < ApplicationController
  def show
    @user = User.find_by!(:key => params[:key])

    @blood_profile = RedCrossAPI.profile(@user.token)
  end
end
