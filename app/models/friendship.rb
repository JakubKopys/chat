class Friendship < ApplicationRecord
  enum status: [:pending, :requested, :accepted]
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def decline
    self.destroy
  end

  def self.request(user, friend)
    unless user == friend || Friendship.exists?(user)
      transaction do
        create(user: user, friend: friend, status: :pending)
        create(user: friend, friend: user, status: :requested)
      end
    end
  end

  def self.accept(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.accept_one_side(user, friend)
    request = find_by(user_id: user, friend_id: friend)
    request.status = :accepted
    request.save!
  end

  def self.remove(user, friend)
    friendship1 = where(user_id: user, friend_id: friend).first
    friendship2 = where(user_id: friend, friend_id: user).first
    friendship1.delete
    friendship2.delete
  end
end
