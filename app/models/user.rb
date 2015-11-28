class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pictures
  has_many :comments
  has_many :likes

  def self.search(term)
    where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
  end
end
