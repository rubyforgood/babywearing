class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :type, null: false
      t.string :name
      t.string :subject, null: false
      t.text :body, null: false
      t.string :when_sent
      t.integer :when_days

      t.timestamps
    end
  end
end
