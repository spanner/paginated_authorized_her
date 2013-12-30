# Here we inject an authorization header for the current user so that the remote service (ie CDB, usually) can 
# apply the proper access controls. It does that by coming back to us for permissions, so the handshake could do with 
# tidying up, but the first priority is to keep the chain secure.

module PaginatedHer::Middleware
  class TokenAuth < Faraday::Middleware

    def call(env)
      if RequestStore.store[:current_user]
        token = RequestStore.store[:auth_token]
        token ||= RequestStore.store[:current_user].authentication_token if RequestStore.store[:current_user]
        if token
          env[:request_headers]["AUTHORIZATION"] = "Token token=#{token}"
        end
      end
      @app.call(env)
    end

  end
end