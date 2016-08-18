###
sendMessage = (e) ->
$messages = $('.messages')
$form = $('#message_body')
if e && e.keyCode == 13
  $msg = $form.val()
  id = $messages.data 'id'

  $.ajax
    type: 'POST'
    url: "/chatrooms/#{id}/messages"
    data: "message[body]=#{$msg}"
    success: ->
      $.get '/get_user', (result) ->
        $name = result.name
        $form.val('')
        $messages.prepend("<div><strong>#{$name}:</strong> #{$msg} </div>")
###