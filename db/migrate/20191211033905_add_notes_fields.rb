class AddNotesFields < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :notes, :text
    add_column :loans, :notes, :text
  end
end
