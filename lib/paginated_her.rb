require 'her'
require 'paginated_her/model'
require 'paginated_her/paginated_array'
require 'paginated_her/middleware/token_auth'
require 'paginated_her/middleware/parser'
require "paginated_her/version"

module PaginatedHer
  class Error < StandardError; end
  class AuthRequired < Error; end
  class ResourceInvalid < Error; end
  class RequestFailed < Error; end
end
