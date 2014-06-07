class Post < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "300x300>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  belongs_to :to_friend, :class_name => 'User', :foreign_key => 'to_friend_id'
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :to_friend_id, presence: true
  validates :content, presence: true, length: { maximum: 140}
end
