class Post < ActiveRecord
  has_many :comments
  belongs_to :user
end
