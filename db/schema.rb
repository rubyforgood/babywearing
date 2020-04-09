# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_28_044747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "agreements", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "item_id"
    t.string "name"
    t.string "manufacturer"
    t.string "model"
    t.string "color"
    t.string "size"
    t.integer "default_loan_length_days", default: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.bigint "home_location_id", null: false
    t.bigint "current_location_id", null: false
    t.string "safety_link"
    t.string "state", default: "available", null: false
    t.text "notes"
    t.integer "weight_limit"
    t.integer "organization_id"
    t.index ["current_location_id"], name: "index_carriers_on_current_location_id"
    t.index ["home_location_id"], name: "index_carriers_on_home_location_id"
    t.index ["state"], name: "index_carriers_on_state"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "fee_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "fee_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "carrier_id"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checkin_volunteer_id"
    t.bigint "checkout_volunteer_id"
    t.bigint "borrower_id", null: false
    t.date "returned_on"
    t.text "notes"
    t.bigint "user_id"
    t.index ["borrower_id"], name: "index_loans_on_borrower_id"
    t.index ["checkin_volunteer_id"], name: "index_loans_on_checkin_volunteer_id"
    t.index ["checkout_volunteer_id"], name: "index_loans_on_checkout_volunteer_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  create_table "membership_types", force: :cascade do |t|
    t.string "name"
    t.integer "fee_cents"
    t.integer "duration_days"
    t.integer "number_of_items"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name", null: false
    t.integer "organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "membership_type_id"
    t.date "effective", null: false
    t.date "expiration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
    t.text "notes"
    t.index ["effective"], name: "index_memberships_on_effective"
    t.index ["expiration"], name: "index_memberships_on_expiration"
    t.index ["membership_type_id"], name: "index_memberships_on_membership_type_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.string "email"
    t.string "phone"
    t.text "notes"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subdomain"], name: "index_organizations_on_subdomain"
  end

  create_table "signed_agreements", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "agreement_id"
    t.string "signature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agreement_id"], name: "index_signed_agreements_on_agreement_id"
    t.index ["user_id"], name: "index_signed_agreements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street_address", null: false
    t.string "street_address_second"
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "phone_number", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 2, null: false
    t.text "notes"
    t.integer "organization_id"
    t.index ["organization_id", "email"], name: "index_users_on_organization_id_and_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carriers", "locations", column: "current_location_id"
  add_foreign_key "carriers", "locations", column: "home_location_id"
  add_foreign_key "loans", "users"
  add_foreign_key "loans", "users", column: "borrower_id"
  add_foreign_key "loans", "users", column: "checkin_volunteer_id"
  add_foreign_key "loans", "users", column: "checkout_volunteer_id"
  add_foreign_key "memberships", "membership_types"
  add_foreign_key "memberships", "users"
end
