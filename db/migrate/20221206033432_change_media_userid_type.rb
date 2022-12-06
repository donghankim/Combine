class ChangeMediaUseridType < ActiveRecord::Migration[6.1]
  def change
    change_column :media, :user_id, :integer
  end
end
