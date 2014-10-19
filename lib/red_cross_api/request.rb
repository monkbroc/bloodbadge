module RedCrossAPI
  class Request
    include HTTParty
    base_uri 'blood.arc.cubeapis.com'

    URL = {
      :authentication => '/v1.0/authentication',
      :profile => '/v1.0/users/me?inflate=history%2Cappointments'
    }

    JSON_HEADERS = { 'Content-Type' => 'application/json' }

    def authentication(params)
      params[:username] = params[:username].try(:upcase)
      response = self.class.post(URL[:authentication],
                      :body => params.to_json,
                      :headers => JSON_HEADERS)

      if response.success?
        {
          :username => params[:username],
          :token => response["token"]
        }
      else
        raise AuthenticationError, response.parsed_response
      end
    end

    def profile(token)
      response = self.class.get(URL[:profile],
                                :headers => authorization_header(token))
      if response.success?
        response.parsed_response
      else
        raise AuthorizationError, response.parsed_response
      end
    end

    private

    def authorization_header(token)
      {
        'Authorization' => token
      }
    end
  end
end

