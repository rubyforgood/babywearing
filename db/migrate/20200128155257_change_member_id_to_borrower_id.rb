class ChangeMemberIdToBorrowerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :loans, :member_id, :borrower_id
  end
end
