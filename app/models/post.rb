class Post < ApplicationRecord
  belongs_to :user

  def user_id
    self.user.id
  end

  def created_at_string
    zone = ActiveSupport::TimeZone.new("Central Time (US & Canada)")
    zoned_time = self.created_at.in_time_zone(zone)
    "#{zoned_time.strftime('%B %e, %Y')} at #{zoned_time.strftime('%l:%M %P')}"
  end
end
