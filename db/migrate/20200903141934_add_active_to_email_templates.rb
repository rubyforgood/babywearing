class AddActiveToEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :email_templates, :active, :boolean, default: false, null: false
  end
end
