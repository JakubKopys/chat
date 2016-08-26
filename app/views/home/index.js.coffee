
$('.pagination').html('Loading')
$('.posts').append('<%= escape_javascript render(@posts) %>')
<% if @posts.next_page %>
$('.pagination').replaceWith('<%= escape_javascript will_paginate(@posts) %>')
<% else %>
$(window).off('scroll')
$('.pagination').remove()
<% end %>
$('.replies').hide()