# frozen_string_literal: true

class Loan
  module FilterImpl
    extend ActiveSupport::Concern

    included do
      scope :search_carrier, ->(query) { joins(:carrier).where("carriers.model ilike ?", "%#{query}%") }
      scope :with_due_date_before, ->(date) { where("due_date <= ?", "%#{date}%") }
      scope :with_due_date_after, ->(date) { where("due_date >= ?", "%#{date}%") }
      scope :with_borrower_id, ->(user_id) { where(borrower_id: user_id) }
      scope :with_checkout_volunteer_id, ->(user_id) { where(checkout_volunteer_id: user_id) }
      scope :with_checkin_volunteer_id, ->(user_id) { where(checkin_volunteer_id: user_id) }

      scope :with_outstanding, lambda { |yes_or_no|
        if yes_or_no == 'Yes'
          where(returned_on: nil)
        else
          where.not(returned_on: nil)
        end
      }

      filterrific(available_filters: [
                    :search_carrier,
                    :with_due_date_before,
                    :with_due_date_after,
                    :with_borrower_id,
                    :with_checkout_volunteer_id,
                    :with_checkin_volunteer_id,
                    :with_outstanding
                  ])
    end

    def self.options_for_borrower_filter
      User.order(:last_name, :first_name).map { |m| [m.name, m.id] }
    end

    def self.options_for_outstanding_filter
      %w[Yes No]
    end

    def self.options_for_volunteer_filters
      User.admins.volunteers.order(:last_name, :first_name).map { |v| [v.name, v.id] }
    end
  end
end
