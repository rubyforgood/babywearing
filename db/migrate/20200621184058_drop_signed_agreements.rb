class DropSignedAgreements < ActiveRecord::Migration[6.0]
  def change
    drop_table :signed_agreements do |t|
      t.bigint :user_id
      t.bigint :agreement_id
      t.string :signature
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index [:agreement_id], name: :index_signed_agreements_on_agreement_id
      t.index [:user_id], name: :index_signed_agreements_on_user_id
    end
  end
end
