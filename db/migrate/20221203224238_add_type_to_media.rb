class AddTypeToMedia < ActiveRecord::Migration[6.1]
  def change
    add_column :media, :type, :string
  end
end
