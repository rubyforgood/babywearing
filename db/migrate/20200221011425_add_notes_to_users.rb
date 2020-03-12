class AddNotesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notes, :text
  end
end
