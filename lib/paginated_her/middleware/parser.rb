# https://gist.github.com/letronje/437b4a72225eb53366c6
#
module PaginatedHer::Middleware
  class Parser < Faraday::Response::Middleware

    def on_complete(env)
      response = env[:response] 
      case response.status
      when 200
        json = parsed_response(env)
        errors = json.delete(:errors) || {}
        metadata = json.delete(:metadata) || []
        body = {:data => json, :errors => errors, :metadata => metadata}
        if env[:response_headers]["X-Pagination"]
          body[:pagination] = JSON.parse(env[:response_headers]["X-Pagination"], :symbolize_names => true)
        end
        env[:body] = body

      when 404
        Rails.logger.warn "!!  Missing resource"
        body = {:data => {}, :errors => "Resource Not Found", :metadata => []}
        env[:body] = body

      when 401
        raise PaginatedHer::AuthRequired

      else
        Rails.logger.warn "!!  Failed request"
        Rails.logger.ap env[:request]
        raise PaginatedHer::RequestFailed
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