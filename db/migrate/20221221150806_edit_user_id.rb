class EditUserId < ActiveRecord::Migration[6.1]
  def change
  end
  remove_column :cats , :user_id
end
