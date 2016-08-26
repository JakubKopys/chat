class ChatroomsController < ApplicationController
  def create
    @chatroom = Chatroom.new
    @friend = User.where(username: params[:friend]).last

    @chatroom.chatroom_users.build(user: @friend, chatroom: @chatroom)
    @chatroom.chatroom_users.build(user: current_user, chatroom: @chatroom)

    @chatroom.save
    @chat_friend = ChatroomUser.where(chatroom: @chatroom, user: @friend).last
    respond_to do |format|
      format.js
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @friend = (@chatroom.chatroom_users - [ChatroomUser.where(user: current_user, chatroom: @chatroom).first])[0]
    @messages = @chatroom.messages.order(created_at: :asc).limit(100)
  end

  def open_chat
    @chatroom = Chatroom.find(params[:id])
    @chat_friend = @chatroom.chatroom_users.where.not(user: current_user.id).first
    @messages = @chatroom.messages.order(created_at: :asc)
    session[:chatrooms] ||= []
    session[:chatrooms].push @chatroom.id
    respond_to do |format|
      format.js
    end
  end

  def del_from_sessions
    id = Chatroom.find(params[:id]).id
    session[:chatrooms].delete(id)
  end

  def active_chatrooms
    @chatrooms = Chatroom.where(id: session[:chatrooms])
    respond_to do |format|
      format.js
    end
  end

end
