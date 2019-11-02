# frozen_string_literal: true

json.extract! fee_type, :id, :created_at, :updated_at
json.url fee_type_url(fee_type, format: :json)
