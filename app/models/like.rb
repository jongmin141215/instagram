class Like < ActiveRecord::Base
  belongs_to :picture
  belongs_to :user
  validates :user, uniqueness: { scope: :picture }
  validates :picture_id, presence: true
  validates :user_id, presence: true
end
