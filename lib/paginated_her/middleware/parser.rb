# https://gist.github.com/letronje/437b4a72225eb53366c6
#
module PaginatedHer::Middleware
  class Parser < Her::Middleware::FirstLevelParseJSON

    def on_complete(env)
      super
      env[:body][:pagination] = parse_json(env[:response_headers]["X-Pagination"]) if env[:response_headers]["X-Pagination"].present?
    end
    
  end
end