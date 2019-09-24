class Post < ApplicationRecord
  belongs_to :user

  def user_id
    self.user.id
  end

  def created_at_string
    "#{self.created_at.strftime('%B %e, %Y')} at #{self.created_at.strftime('%l:%M %P')}"
  end
end
