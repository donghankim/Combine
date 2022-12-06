class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :owner_id
      t.string :imdb_id
      t.string :title
      t.string :director
      t.string :genre
      t.float :rating

      t.timestamps
    end
    add_index :media, :owner_id
  end
end
