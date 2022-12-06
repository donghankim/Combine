class RemoveSummaryFromMedia < ActiveRecord::Migration[6.1]
  def change
    remove_column :media, :summary, :string
  end
end
