class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name , null:false
      t.string :password_digest , null:false

      t.timestamps
    end
    add_index :users , :user_name
  end
end
