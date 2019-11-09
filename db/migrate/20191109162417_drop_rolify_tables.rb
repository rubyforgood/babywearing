class DropRolifyTables < ActiveRecord::Migration[5.2]
  def change
    drop_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    drop_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end
  end
end
