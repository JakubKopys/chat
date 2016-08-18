class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(data)
    id = data['chatroom_id']
    chatroom = Chatroom.find(id)
    user = User.find(data['user_id'])
    message = chatroom.messages.create! body: data['message'], user: user
    ActionCable.server.broadcast "chatrooms:#{id}", {
        message: ApplicationController.render_with_signed_in_user(user, message),
        chatroom_id: id,
        message_id: message.id,
        sender_id: user.id
    }
  end
end
