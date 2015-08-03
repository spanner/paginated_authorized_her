module Her
  class Collection

    def _pagination_data
      metadata[:pagination].presence || {}
    end

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
  end
end
