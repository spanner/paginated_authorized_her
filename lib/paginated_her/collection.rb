module Her
  class Collection

    def _pagination_data
      metadata[:pagination].presence || {}
    end

    # pagination metadata

    def current_page
      _pagination_data[:current_page]
    end

    def per_page
      _pagination_data[:per_page]
    end

    def next_page
      _pagination_data[:next_page]
    end

    def prev_page
      _pagination_data[:prev_page]
    end

    def total_pages
      _pagination_data[:total_pages]
    end

    def total_count
      _pagination_data[:total_count]
    end

    # ducks for kaminari

    alias :limit_value :per_page

    # pagination helpers

    def last_page?
      _pagination_data[:current_page] == _pagination_data[:total_pages]
    end

    def first_page?
      _pagination_data[:current_page] == 1
    end

    def first_item_index
      (current_page - 1) * per_page + 1
    end

    def last_item_index
      if last_page?
        total_count
      else
        first_item_index + per_page - 1
      end
    end

    # faceting metadata

    def facets
      metadata[:facets].presence || {}
    end
    
    def facet(name)
      if facet = facets[name.to_sym]
        facet[:terms]
      else
        {}
      end
    end

  end
end
