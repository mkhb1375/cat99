class AddSessionToken < ActiveRecord::Migration[6.1]
  def change
   
  end
  add_column(:users, :session_token, :string , null: false)
  add_index :users , :session_token
end
