class ChatroomUser < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  def chat_friend
    (self.chatroom.chatroom_users - [self])[0]
  end

end
