class DropTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :games
    drop_table :movies
    drop_table :podcasts
    drop_table :tv_shows
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
