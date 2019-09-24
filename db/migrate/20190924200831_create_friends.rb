class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends, :force => true, :id => false do |t|
      t.integer :user_a_id, :null => false
      t.integer :user_b_id, :null => false
    end
  end
end
