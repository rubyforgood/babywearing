class AddReplyEmailToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :reply_email, :string, null: false, default: 'noreply@example.com'
  end
end
