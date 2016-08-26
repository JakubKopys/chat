App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0
      active_chatroom.append(data.message)
      if $('#new_message').data('userid') != data.sender_id
        $("[data-message-id='#{data.message_id}']").removeClass()
        $("[data-message-id='#{data.message_id}']").addClass("other")
      scroll_to_bottom(data.chatroom_id)
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").addClass('notify');

  speak: (data) ->
    @perform 'speak', message: data['message'], chatroom_id: data['chatroom_id'], user_id: data['user_id']

  add: (data) ->
    @perform 'add', chatroom_id: data['chatroom_id']

$(document).on "keypress", '#new_message', (e) ->
  if e && e.keyCode == 13
    e.preventDefault()
    if e.target.value.trim().length > 0
      $chatroom_id = e.target.getAttribute('data-chatroom-id')
      console.log $chatroom_id
      $user_id = $('meta[name=user-id]').attr("content")
      console.log $user_id
      console.log e.target.value
      if e.target.getAttribute('data-behavior') == "created-chatroom"
        App.chatrooms.add chatroom_id: $chatroom_id
        e.target.removeAttribute('data-behavior')
      App.chatrooms.speak message: e.target.value, chatroom_id: $chatroom_id, user_id: $user_id
      e.target.value = ''

scroll_to_bottom = (id) ->
  $messages = $(".discussion[data-chatroom-id='#{id}'")
  if $messages.length > 0
    height = $messages[0].scrollHeight
    $messages.scrollTop(height)