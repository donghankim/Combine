class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :name
      t.string :company
      t.integer :year
      t.string :genre
      t.integer :rating

      t.timestamps
    end
    add_index :games, :user_id
  end
end
