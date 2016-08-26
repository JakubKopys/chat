unless $(".chat_box[data-chatbox-id='<%=@chatroom.id%>']").length > 0
  boxes = $('.chat_box')
  $(document.body).append("<%= j render '/chatrooms/chatroom', chatroom: @chatroom, friend: @chat_friend, messages: @messages %>")
  if boxes.length > 0
    $box = $(".chat_box[data-chatbox-id='<%=@chatroom.id%>']")
    my = 310*boxes.length
    my.toString()
    $box.css( 'right', '+=' + my + 'px' )
  setTimeout( ->
    scroll_messages_to_bottom()
  , 10)

  scroll_messages_to_bottom = () ->
    $messages = $(".discussion[data-chatroom-id='<%=@chatroom.id%>'")
    if $messages.length > 0
      height = $messages[0].scrollHeight
      $messages.scrollTop(height)

  $(document).on "click", ".top-bar[data-chatbox-id='<%=@chatroom.id%>'] .fa-times", (e) ->
    $box_position = $("div.chat_box[data-chatbox-id='<%=@chatroom.id%>']").position().left
    $("div.chat_box[data-chatbox-id='<%=@chatroom.id%>']").remove()
    $.get "/chatrooms/<%=@chatroom.id%>/del_from_sessions"
    chats = $('.chat_box')
    chats.each (index, element) =>
      if $(element).position().left < $box_position
        $(element).css( 'right', '-=' + 310 + 'px' )