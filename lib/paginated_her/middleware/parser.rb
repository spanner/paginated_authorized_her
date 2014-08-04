module PaginatedHer::Middleware
  class Parser < Her::Middleware::FirstLevelParseJSON
    def parse(body)
      Rails.logger.debug "Parser#parse #{body.inspect}"
      super
    end

    def on_complete(env)
      Rails.logger.debug "Parser#on_complete"
      env[:body] = case env[:status]
      when 204
        parse('{}')
      when 401, 403
        raise PaginatedHer::AuthRequired, "API responded with auth request or not allowed"
      else
        parse(env[:body])
      end
      env[:body][:pagination] = parse_json(env[:response_headers]["X-Pagination"]) if env[:response_headers]["X-Pagination"].present?
    end

  end
end