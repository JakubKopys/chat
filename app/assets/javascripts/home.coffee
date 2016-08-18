# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.add').hide()
  $('.replies').hide()

  #toggle new post form.
  $('.toggle').on 'click', ->
    $('.add').slideToggle 400, ->
      if $(this).is ":visible"
        $(".toggle").html 'hide form'
        $(".toggle").animate {'margin': '40px 0'}, 200
        $("ul#notice li").animate {'opacity': '0'}, 400, ->
            $("ul#notice").html ''
      else
        $(".toggle").html 'Add post'
        $(".toggle").animate {'margin': '40px 0'}, 200
        $("ul#notice li").animate {'opacity': '0'}, 400, ->
          $("ul#notice").html ''

  # display lightbox on image click.
  # $(".post_thumb").click(function(e){
  # event delegation to attach events for dynamically loaded elements !!!
  $(this).on 'click', '.post_thumb', (e) ->
    image_href = $(this).attr "href"
    $(".box").html $('<img>',{class:'added',src:image_href})
    img = document.getElementsByClassName 'added'
    width = img.naturalWidth
    height = img.naturalHeight
    $(".backdrop").animate {'opacity':'0.5'}, 300, 'linear'
    $(".box").animate {'opacity':'1.0'}, 300, 'linear'
    $(".backdrop, .box").css "display", "block"
    $(".backdrop").css "height", $(document).height()
    $(".added").css "top", $(window).scrollTop()+60
    e.preventDefault();

  setTimeout( ->
    $(".flash").fadeOut("fast")
  , 2500)

  # close lightbox after clicking outseide of it.
  $(this).on 'click','.backdrop', ->
    close_box();


  setTimeout( ->
    scroll_messages_to_bottom()
  , 300)

  # manual ajax submit to get refreshles image uploads
  # TODO: implement same for comments
  $("input#add_post").click (e)  ->
    e.preventDefault()
    $id = $(this).data 'current-user-id'
    $content = $('.content_area').val()
    $image = $('.post_image').prop('files')

    $form_data = new FormData()
    $form_data.append("post[content]", $content)
    if $image.length > 0
      $file_data = $('.post_image').prop('files')[0] # Getting the properties of file from file field
      $form_data.append("post[image]", $file_data)

    $.ajax
      type: "POST",
      url: "/users/#{$id}/posts",
      data: $form_data,
      contentType: false,
      processData: false,
      dataType: 'JSON',
      success: (data) ->
        $("ul#notice").css('opacity', '0')
        $("ul#notice").html('')
        $.get '/render_post', {user_id: $id, id: data.id}, (result) ->
         $('.posts').prepend result.view
      error: (xhr, status, error) ->
        errors = xhr.responseJSON.error
        $("ul#notice").html('')
        for msg in errors
          $("ul#notice").append($("<li />").html(msg))
        $("ul#notice").css('opacity', '1')
    .done clear_post_form()

clear_post_form = () ->
  $('.image_upload_preview').removeAttr('src');
  $('.add .tooltip').html('Add image');
  $('.content_area').val('');

scroll_messages_to_bottom = () ->
  $messages = $('.discussion')
  if $('.discussion').length > 0
    height = $messages[0].scrollHeight
    $messages.scrollTop(height)

close_box = () ->
  $('.backdrop, .box, .added').animate {'opacity':'0'}, 300, 'linear', ->
    $(".backdrop, .box, .added").css 'display', 'none'
