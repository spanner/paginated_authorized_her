module PaginatedHer
  module Model
    extend ActiveSupport::Concern
    include Her::Model
    
    included do
      include_root_in_json true
      after_save :decache
      after_create :decache_index
    end
    
    def decache
      if $cache
        pk = self.attributes[self.class.primary_key]
        cache_key = self.class.resource_path.gsub(/:id/, pk.to_s)
        p "deleting #{cache_key} from #{$cache.inspect}"
        $cache.delete cache_key
      end
    end

    def decache_index
      self.class.decache_index
    end

    module ClassMethods
      # We are overriding the standard collection with a pagination-respecting equivalent.
      # the parsed_data argument is given in a call from our PaginatedParser, which you can
      # find in /lib/her/middleware. All it does is to eat headers and add the :pagination 
      # key we are about to read.
      #
      def new_collection(parsed_data)
        initialize_collection(parsed_data)
      end

      def initialize_collection(parsed_data={})
        collection = Her::Model::Attributes.initialize_collection(self, parsed_data)
        if parsed_data[:pagination]
          Kaminari.paginate_array(collection, parsed_data[:pagination])
        else
          collection
        end
      end

      def decache_index
        if $cache
          cache_key = collection_path
          p "deleting #{cache_key} from #{$cache.inspect}"
          $cache.delete cache_key
        end
      end
    

    end
  end

end