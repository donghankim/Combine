class CreatePodcasts < ActiveRecord::Migration[6.1]
  def change
    create_table :podcasts do |t|
      t.integer :user_id
      t.string :name
      t.string :company
      t.string :recent_episode
      t.string :genre
      t.float :rating

      t.timestamps
    end
    add_index :podcasts, :user_id
  end
end
