class CreateSignatures < ActiveRecord::Migration[6.0]
  def change
    create_table :signatures do |t|
      t.references :user, null: false, foreign_key: true
      t.references :agreement_version, null: false, foreign_key: true
      t.string :signature, null: false
      t.datetime :signed_at, null: false
      t.timestamps
    end
  end
end
