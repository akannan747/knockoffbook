class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_id
      t.integer :recipient_id
    end
  end
end
