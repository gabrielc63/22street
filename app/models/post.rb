class Post < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "300x300>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :topic, :class_name => 'Post'
  has_many :replies, :class_name => 'Post', :foreign_key => 'topic_id', dependent: :destroy
  belongs_to :user
  belongs_to :to_friend, :class_name => 'User', :foreign_key => 'to_friend_id'
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :to_friend_id, presence: true
  validates :content, presence: true, length: { maximum: 300}

  auto_html_for :content do
    html_escape
    image
    youtube(:width => 300, :height => 200, :autoplay => false)
    vimeo(:width => 300, :height => 200, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
