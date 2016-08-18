class ChatroomsController < ApplicationController
  def create
    @chatroom = Chatroom.new
    @friend = User.where(username: params[:friend]).last

    @chatroom.chatroom_users.build(user: @friend, chatroom: @chatroom)
    @chatroom.chatroom_users.build(user: current_user, chatroom: @chatroom)

    if @chatroom.save
      flash[:notice] = "chatrooom created"
      redirect_to @chatroom
    else
      flash[:notice] = "chatrooom not created lol"
      redirect_to authenticated_root_path
    end

  end

  def show
    @chatroom = Chatroom.find(params[:id])

    @chatroom_users = @chatroom.chatroom_users.includes(:user)
    @messages = @chatroom.messages.order(created_at: :asc)
  end

  private

  def chatroom_exists?

  end
end
