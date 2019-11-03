# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_03_121749) do

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
    t.integer "status", default: 0, null: false
    t.index ["current_location_id"], name: "index_carriers_on_current_location_id"
    t.index ["home_location_id"], name: "index_carriers_on_home_location_id"
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
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer "carrier_id"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checkin_volunteer_id"
    t.bigint "checkout_volunteer_id"
    t.bigint "member_id", null: false
    t.datetime "returned_at"
    t.index ["checkin_volunteer_id"], name: "index_loans_on_checkin_volunteer_id"
    t.index ["checkout_volunteer_id"], name: "index_loans_on_checkout_volunteer_id"
    t.index ["member_id"], name: "index_loans_on_member_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "membership_types", force: :cascade do |t|
    t.string "name"
    t.integer "fee_cents"
    t.integer "duration_days"
    t.integer "number_of_items"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
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
    t.datetime "deactivated_at"
    t.string "first_name"
    t.string "last_name"
    t.index ["deactivated_at"], name: "index_users_on_deactivated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carriers", "locations", column: "current_location_id"
  add_foreign_key "carriers", "locations", column: "home_location_id"
  add_foreign_key "loans", "users", column: "checkin_volunteer_id"
  add_foreign_key "loans", "users", column: "checkout_volunteer_id"
  add_foreign_key "loans", "users", column: "member_id"
end
