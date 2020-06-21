class AgreementColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :agreements, :title, :name
    change_column_null :agreements, :name, null: false
    remove_column :agreements, :content, :string
  end
end
