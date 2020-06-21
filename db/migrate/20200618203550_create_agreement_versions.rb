class CreateAgreementVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :agreement_versions do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :agreement, null: false, foreign_key: true
      t.references :last_modified_by, foreign_key: { to_table: :users }, index: false
      t.string :version, null: false
      t.boolean :active, default: false, null: false
      t.timestamps
    end
  end
end
