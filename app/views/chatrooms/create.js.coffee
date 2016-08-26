boxes = $('.chat_box')
$(document.body).append("<%= j render '/chatrooms/chatroom', chatroom: @chatroom, friend: @chat_friend, messages: Message.none %>")
# TODO: dodaj tą datę żeby ACtionCable nie wariował, zmień ten link na to żeby pokazywał a nie tworzył znowqu
$("a[data-user='<%=@friend.id%>']").attr("data-chatroom-id", <%= @chatroom.id %>)
$("#message_body[data-chatroom-id='<%=@chatroom.id%>']").attr("data-behavior", "created-chatroom")
if boxes.length > 0
  $box = $(".chat_box[data-chatbox-id='<%=@chatroom.id%>']")
  my = 310*boxes.length
  my.toString()
  $box.css( 'right', '+=' + my + 'px' )


$(document).on "click", ".top-bar[data-chatbox-id='<%=@chatroom.id%>'] .fa-times", (e) ->
  $box_position = $("div.chat_box[data-chatbox-id='<%=@chatroom.id%>']").position().left
  $("div.chat_box[data-chatbox-id='<%=@chatroom.id%>']").remove()
  chats = $('.chat_box')
  chats.each (index, element) =>
    if $(element).position().left < $box_position
      $(element).css( 'right', '-=' + 310 + 'px' )