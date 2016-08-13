class Chatroom < ApplicationRecord
  has_many :chatroom_users, :dependent => :destroy
  has_many :users, through: :chatroom_users
  has_many :messages
  before_validation :duplicate?

  # Checks if chatroom containing specific users exists.
  def duplicate?
    is_duplicate = (Chatroom.all.to_a - [self]).any? do |chatroom|
      chatroom.users.map(&:id).sort == self.chatroom_users.map(&:user_id).sort
    end

    if is_duplicate
      errors.add(:chatroom, "Such chatroom already exists.")
    end
  end

  def self.exist?(user, friend)
    users = [user, friend]
    exist = Chatroom.all.to_a.any? do |c|
      c.users.sort == users.sort
    end
  end

end
