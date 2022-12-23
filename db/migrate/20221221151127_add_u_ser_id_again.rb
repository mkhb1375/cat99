class AddUSerIdAgain < ActiveRecord::Migration[6.1]
  def change
  end
  add_column :cats, :user_id, :integer
  add_index :cats , :user_id
end
