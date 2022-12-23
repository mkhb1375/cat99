class RemoveUserIdIndex < ActiveRecord::Migration[6.1]
  def change
    
  end
  remove_index :cats , :user_id
end
