class User < ApplicationRecord
  has_secure_password
  validates :user_name, presence: true, uniqueness: true

  has_many :posts
  has_and_belongs_to_many(:users,
    :join_table => "friends",
    :foreign_key => "user_a_id",
    :association_foreign_key => "user_b_id")

  def to_string
    "#{self.first_name} #{self.last_name}"
  end
end
