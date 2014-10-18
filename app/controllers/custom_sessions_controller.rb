##
# Devise Controller for logging in
#
 
class CustomSessionsController < Devise::SessionsController

  
  # POST /resource/sign_in
  def create
    # Authenticate using RedCrossApi
    results = RedCrossAPI.authentication(authentication_params)

    # If user doesn't exist yet, create it
    self.resource = resource_class.find_or_create_by(:username => results[:username].downcase) do |user|
      user.token = results[:token]
    end

    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)

  rescue RedCrossAPI::AuthenticationError
    flash[:notice] = "Invalid username or password"
    render "#new"
  end


  private

  def authentication_params
    params.require(:user).permit(:username, :password)
  end
end

