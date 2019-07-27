class UpdateDefaultLoanLengthName < ActiveRecord::Migration[5.2]
  def change
    rename_column :carriers, :default_loan_length, :default_loan_length_days
  end
end
