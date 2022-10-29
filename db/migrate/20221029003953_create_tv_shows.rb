class CreateTvShows < ActiveRecord::Migration[6.1]
  def change
    create_table :tv_shows do |t|
      t.integer :user_id
      t.string :name
      t.string :director
      t.string :show_stars
      t.integer :seasons
      t.string :genre
      t.float :rating

      t.timestamps
    end
    add_index :tv_shows, :user_id
  end
end
