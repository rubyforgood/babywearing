class CreateSignedAgreements < ActiveRecord::Migration[5.2]
  def change
    create_table :signed_agreements do |t|
      t.belongs_to :user
      t.belongs_to :agreement
      t.string :signature
      t.timestamps
    end
  end
end
