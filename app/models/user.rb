class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  scope :username_like, -> (name) { where("username ilike ?", name)}
  has_many :messages
  has_many :chatrooms, through: :chatroom_users
  has_many :chatroom_users, :dependent => :destroy

  has_many :friendships
  has_many :accepted_friendships, -> { where(status: Friendship.statuses[:accepted]) }, class_name: 'Friendship'
  has_many :requested_friendships, -> { where(status: Friendship.statuses[:requested]) }, class_name: 'Friendship'
  has_many :pending_friendships, -> { where(status: Friendship.statuses[:pending]) }, class_name: 'Friendship'

  #accetped friends
  has_many :friends, through: :accepted_friendships, after_remove: :remove_complement_friendship

  #users that requested friendship with user
  has_many :requested_friends, through: :requested_friendships, source: :friend

  #users that user requested friendship with
  has_many :pending_friends, through: :pending_friendships, source: :friend

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  has_attached_file :avatar, styles: { medium: "40x40!", thumb: "30x30!", big: "250x250>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  # Returns true when the user likes post.
  def likes?(likeable)
    Like.find_by(likeable: likeable, user: self, like: true)
  end

  def get_friendship(user)
    Friendship.where(user_id: self, friend_id: user).first
  end

  def is_friends_with?(user)
    Friendship.exists?(user_id: self, friend_id: user, status: Friendship.statuses[:accepted])
  end

  def request_pending?(user)
    Friendship.exists?(user_id: self, friend_id: user, status: Friendship.statuses[:requested])
  end

  def requested_friendship?(user)
    Friendship.exists?(user_id: self, friend_id: user, status: Friendship.statuses[:pending])
  end

  def unaccepted_friends
    requested_friends + pending_friends
  end

  def feed
    friends_ids = friends.ids
    Post.where("user_id IN (:friends_ids) OR user_id = :user_id", friends_ids: friends_ids, user_id: id)
  end

  def get_chatroom_with(friend)
    #Chatroom.joins(:users).where("users.id" => [self.id, friend.id]).where("users.id" => [friend.id]).last
    self.chatrooms.includes(:users).each do |chatroom|
      if chatroom.users.first == friend || chatroom.users.second == friend
        return chatroom
      end
    end
  end

  private

  def create_complement_friendship(friend)
    self.friends << friend unless friend.friends.include?(self)
  end

  def remove_complement_friendship(friend)
    friend.friends.delete(self)
  end

end
