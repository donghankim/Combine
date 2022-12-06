class RenameMediaAttr < ActiveRecord::Migration[6.1]
  def change
    rename_column :media, :owner_id, :user_id
  end
end
