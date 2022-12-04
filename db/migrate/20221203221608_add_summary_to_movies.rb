class AddSummaryToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :summary, :string
  end
end
