# https://gist.github.com/letronje/437b4a72225eb53366c6
#
module PaginatedHer::Middleware
  class Parser < Faraday::Response::Middleware

    def on_complete(env)
      # faraday 0.9.0
      status = env[:status] 
      # faraday 0.8.x
      status ||= env[:response].status if env[:response] 

      case status
      when 200, 201
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
        body = {:data => {}, :errors => "Request failed with status #{status}", :metadata => []}
        env[:body] = body
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