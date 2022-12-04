class AddSummaryToMedia < ActiveRecord::Migration[6.1]
  def change
    add_column :media, :summary, :string
  end
end
