# frozen_string_literal: true

class Carrier
  module FilterImpl
    extend ActiveSupport::Concern

    included do
      scope :search_manufacturer, ->(query) { where("manufacturer ilike ?", "%#{query}%") }
      scope :search_item_id, ->(query) { where("item_id ilike ?", "%#{query}%") }
      scope :search_model, ->(query) { where("model ilike ?", "%#{query}%") }
      scope :search_name, ->(query) { where("name ilike ?", "%#{query}%") }
      scope :with_category_id, ->(category_id) { where("category_id = ?", category_id) }
      scope :with_current_location_id, ->(current_location_id) { where("current_location_id = ?", current_location_id) }
      scope :with_status, ->(status) { where("status = ?", statuses[status.downcase]) }
      scope :with_checked_out, lambda { |checked_out|
        if checked_out == 'Yes'
          joins(:loans).where('loans.checkin_volunteer_id IS NULL')
        elsif checked_out == 'No'
          left_outer_joins(:loans).where('loans.carrier_id IS NULL or loans.checkin_volunteer_id IS NOT NULL')
        end
      }

      filterrific(available_filters: [
                    :search_manufacturer,
                    :search_item_id,
                    :search_model,
                    :search_name,
                    :with_category_id,
                    :with_current_location_id,
                    :with_status,
                    :with_checked_out
                  ])
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

    def self.options_for_yes_no_filter
      ['Yes', 'No']
    end
  end
end
