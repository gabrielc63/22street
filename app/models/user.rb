class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :posts_received, :class_name => 'Post', :foreign_key=> 'to_friend_id'
  has_attached_file :avatar, :styles => { :thumb => "100x100>" },
                    :default_url => ActionController::Base.helpers.asset_path('missing_thumbnail.png')
                     # "/images/:style/missing.png"

  validates_attachment :avatar,
    :content_type => { :content_type => ["image/jpeg", "image/png"] },
    :size => { :in => 0..100.kilobytes }
  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 10}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    result = posts.where(topic_id: nil) + posts_received.where(topic_id: nil)
    result.sort_by {|f| f.created_at }.reverse!
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
