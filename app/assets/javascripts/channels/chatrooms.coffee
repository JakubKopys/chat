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
      scroll_to_bottom()
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").addClass('notify');
    # Called when there's incoming data on the websocket for this channel

  speak: (data) ->
    @perform 'speak', message: data['message'], chatroom_id: data['chatroom_id'], user_id: data['user_id']

$(document).on "turbolinks:load", ->
  $("#new_message").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      if e.target.value.trim().length > 0
        $chatroom_id = $("[data-behavior='send-message']").data('chatroomid')
        $user_id = $("[data-behavior='send-message']").data('userid')
        App.chatrooms.speak message: e.target.value, chatroom_id: $chatroom_id, user_id: $user_id
        e.target.value = ''

scroll_to_bottom = () ->
  $messages = $('.discussion')
  height = $messages[0].scrollHeight
  $messages.scrollTop(height+10)