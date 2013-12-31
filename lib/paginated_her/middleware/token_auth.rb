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