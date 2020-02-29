class ChangeAmountFieldToFeeCents < ActiveRecord::Migration[5.2]
  def change
    rename_column :fee_types, :amount, :fee_cents
  end
end
