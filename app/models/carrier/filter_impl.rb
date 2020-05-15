# frozen_string_literal: true

class Carrier
  module FilterImpl
    extend ActiveSupport::Concern

    included do
      scope :search_manufacturer, ->(query) { where('manufacturer ilike ?', "%#{query}%") }
      scope :search_item_id, ->(query) { where('item_id ilike ?', "%#{query}%") }
      scope :search_model, ->(query) { where('model ilike ?', "%#{query}%") }
      scope :search_name, ->(query) { where('name ilike ?', "%#{query}%") }
      scope :with_category_id, ->(category_id) { where('category_id = ?', category_id) }
      scope :with_current_location_id, ->(current_location_id) { where('current_location_id = ?', current_location_id) }
      scope :with_state_in, ->(state) { where(state: state) }

      filterrific(available_filters: %i[
                    search_manufacturer
                    search_item_id
                    search_model
                    search_name
                    with_category_id
                    with_current_location_id
                    with_state_in
                  ])
    end

    def self.options_for_category_filter
      Category.order(:name).map { |c| [c.name, c.id] }
    end

    def self.options_for_current_location_filter
      Location.order(:name).map { |l| [l.name, l.id] }
    end
  end
end
