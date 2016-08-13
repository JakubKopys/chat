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

  # close lightbox after clicking outseide of it.
  $(this).on 'click','.backdrop', ->
    close_box();

close_box = () ->
  $('.backdrop, .box, .added').animate {'opacity':'0'}, 300, 'linear', ->
    $(".backdrop, .box, .added").css 'display', 'none'