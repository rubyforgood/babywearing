# frozen_string_literal: true

class Carrier
  module FilterImpl
    extend ActiveSupport::Concern

    included do
      scope :search_manufacturer, ->(query) { where("manufacturer ilike ?", "%#{query}%") }
      scope :search_model, ->(query) { where("model ilike ?", "%#{query}%") }
      scope :search_name, ->(query) { where("name ilike ?", "%#{query}%") }
      scope :with_category_id, ->(category_id) { where("category_id = ?", category_id) }
      scope :with_current_location_id, ->(current_location_id) { where("current_location_id = ?", current_location_id) }
      scope :with_status, ->(status) { where("status = ?", statuses[status.downcase]) }

      filterrific(
        available_filters: [
          :with_category_id,
          :with_current_location_id,
          :with_status,
          :search_name,
          :search_manufacturer,
          :search_model
        ]
      )
    end

    def self.options_for_category_filter
      Category.order(:name).map { |c| [c.name, c.id] }
    end

    def self.options_for_current_location_filter
      Location.order(:name).map { |l| [l.name, l.id] }
    end

    def self.options_for_status_filter
      Carrier.statuses.keys.sort.map(&:titleize)
    end
  end
end
