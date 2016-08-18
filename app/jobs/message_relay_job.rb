class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(data)
    id = data['chatroom_id']
    chatroom = Chatroom.find(id)
    message = chatroom.messages.create! body: data['message'], user: User.find(data['user_id'])
    ActionCable.server.broadcast "chatrooms:#{id}", {
        message: MessagesController.render(message),
        chatroom_id: id
    }
  end
end
