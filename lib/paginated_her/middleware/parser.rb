# https://gist.github.com/letronje/437b4a72225eb53366c6
#
module PaginatedHer::Middleware
  class Parser < Faraday::Response::Middleware

    def on_complete(env)
      response = env[:response]
      if response.success?
        json = parsed_response(env)
        errors = json.delete(:errors) || {}
        metadata = json.delete(:metadata) || []
        body = {:data => json, :errors => errors, :metadata => metadata}
        if env[:response_headers]["X-Pagination"]
          body[:pagination] = JSON.parse(env[:response_headers]["X-Pagination"], :symbolize_names => true)
        end
        env[:body] = body
      else
        if response.status == 401
          raise PaginatedHer::AuthRequired
        else
          raise PaginatedHer::RequestFailed
        end
      end
    end
    
    def parsed_response(env)
      begin
        JSON.parse(env[:body], :symbolize_names => true)
      rescue => e
        Rails.logger.warn "JSON parse failure: #{e}"
        {}
      end
    end
    
  end
end