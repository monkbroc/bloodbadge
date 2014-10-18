module RedCrossAPI
  class Request
    include HTTParty
    base_uri 'blood.arc.cubeapis.com'

    URL = {
      :authentication => '/v1.0/authentication',
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
        raise response.parsed_response
      end
    end

  end
end

