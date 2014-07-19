# Make our already-paginated array respond to the calls that Kaminari will use to 
# build pagination controls.

module PaginatedHer
  class PaginatedArray < Array

    attr_internal_accessor :limit_value, :offset_value, :total_count

    def initialize(array = [], options = {})
      @_limit_value, @_offset_value, @_total_count = options[:limit].to_i, options[:offset].to_i, options[:total_count].to_i
      super(array)
    end

    def entry_name
      "entry"
    end
    
    def max_per_page
      100
    end
    
    def current_page
      (offset_value / limit_value) + 1
    end
    
    def next_page
      current_page + 1 unless last_page?
    end

    # Previous page number in the collection
    def prev_page
      current_page - 1 unless first_page?
    end
    
    # First page of the collection?
    def first_page?
      current_page == 1
    end

    # Last page of the collection?
    def last_page?
      current_page >= total_pages
    end

    # Out of range of the collection?
    def out_of_range?
      current_page > total_pages
    end
    
    def total_pages
      (total_count.to_f / limit_value).ceil
    end
  end

end
