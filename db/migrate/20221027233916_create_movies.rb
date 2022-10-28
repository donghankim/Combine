class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director
      t.string :movie_stars
      t.integer :year
      t.string :genre
      t.float :rating

      t.timestamps
    end
  end
end
