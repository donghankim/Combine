class AddPosterToMedia < ActiveRecord::Migration[6.1]
  def change
    add_column :media, :poster_url, :string
  end
end
