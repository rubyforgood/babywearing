# frozen_string_literal: true

json.extract! membership_type, :id, :name, :fee, :duration, :number_of_items, :description, :created_at, :updated_at
json.url membership_type_url(membership_type, format: :json)
