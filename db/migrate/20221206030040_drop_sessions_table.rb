class DropSessionsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :sessions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
