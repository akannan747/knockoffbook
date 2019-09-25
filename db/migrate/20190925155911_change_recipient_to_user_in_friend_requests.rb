class ChangeRecipientToUserInFriendRequests < ActiveRecord::Migration[6.0]
  def change
    rename_column :friend_requests, :recipient_id, :user_id 
  end
end
