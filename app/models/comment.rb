class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture
  validates :content, presence: true
end
