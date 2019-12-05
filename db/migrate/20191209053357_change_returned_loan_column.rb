class ChangeReturnedLoanColumn < ActiveRecord::Migration[5.2]
  def up
    remove_column :loans, :returned_at
    add_column :loans, :returned_on, :date
  end
  def down
    remove_column :loans, :returned_on
    add_column :loans, :returned_at, :timestamp
  end
end
