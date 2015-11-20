class Picture < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "500x500>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  has_many :comments
  validates :image, attachment_presence: true

  def build_with_user(params, user)
    comment = self.comments.build(params)
    comment.user = user
    comment
  end
end
