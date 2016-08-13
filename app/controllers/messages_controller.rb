class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.build message_params
    @message.user = current_user
    @message.save
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
