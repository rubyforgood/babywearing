# frozen_string_literal: true

class User
  module FilterImpl
    extend ActiveSupport::Concern

    included do
      scope :search_name, lambda(&method(:name_search))
      scope :search_email, ->(email) { where('email ilike ?', "%#{email}%") }
      scope :with_created_after, ->(date) { where('users.created_at > ?', parsed_created_after(date)) }
      scope :with_role, ->(role) { where(role: role) }

      scope :with_membership_status, lambda { |status|
        case status
        when 'Current'
          with_current_membership
        when 'Expired'
          with_expired_membership.where.not(id: with_current_membership)
        when 'None'
          without_membership
        end
      }

      filterrific(available_filters: %i[
                    search_name
                    search_email
                    with_created_after
                    with_role
                    with_membership_status
                  ])
    end

    def self.options_for_membership_filter
      %w[Current Expired None]
    end

    def self.options_for_role_filter
      User.roles.sort.map { |r| [r.first.titleize, r.second] }
    end
  end

  def self.name_search(query)
    splitted = query.strip.split(' ')
    if splitted.length > 1
      where('first_name ilike ? and last_name ilike ?', "%#{splitted.first}%", "%#{splitted.last}%")
    else
      where('first_name ilike ? or last_name ilike ?', "%#{splitted.first}%", "%#{splitted.first}%")
    end
  end

  def self.parsed_created_after(date)
    Date.parse(date).beginning_of_day
  rescue Date::Error
    (Date.today - 100.years)
  end
end
