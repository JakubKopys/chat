<% @chatrooms.distinct.each do |chat| %>
unless $(".chat_box[data-chatbox-id='<%=chat.id%>']").length > 0
  boxes = $('.chat_box')
  $(document.body).append("<%= j render '/chatrooms/chatroom', chatroom: chat, friend: chat.chatroom_users.where.not(user: current_user.id).first, messages: chat.messages.order(created_at: :asc) %>")
  if boxes.length > 0
    $box = $(".chat_box[data-chatbox-id='<%=chat.id%>']")
    my = 310*boxes.length
    my.toString()
    $box.css( 'right', '+=' + my + 'px' )
  setTimeout( ->
    scroll_messages_to_bottom()
  , 0)

  scroll_messages_to_bottom = () ->
    $messages = $(".discussion[data-chatroom-id='<%=chat.id%>'")
    if $messages.length > 0
      height = $messages[0].scrollHeight
      $messages.scrollTop(height)

  $(".top-bar[data-chatbox-id='<%=chat.id%>'] .fa-times").on 'click', (e) ->
    e.preventDefault()
    $box_position = $("div.chat_box[data-chatbox-id='<%=chat.id%>']").position().left
    $("div.chat_box[data-chatbox-id='<%=chat.id%>']").remove()
    $.get "/chatrooms/<%=chat.id%>/del_from_sessions", {id: <%=chat.id%>}
    chats = $('.chat_box')
    chats.each (index, element) =>
      if $(element).position().left < $box_position
        $(element).css( 'right', '-=' + 310 + 'px' )
<% end %>
