// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require private_pub
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    $(".post_thumb").click(function(e){
        var image_href = $(this).attr("href");
        $(".box").html($('<img>',{class:'added',src:image_href}));
        var img = document.getElementsByClassName('added');
        var width = img.naturalWidth;
        var height = img.naturalHeight;
        $(".backdrop").animate({'opacity':'0.5'}, 300, 'linear');
        $(".box").animate({'opacity':'1.0'}, 300, 'linear');
        $(".backdrop, .box").css("display", "block");
        $(".backdrop").css("height", $(document).height());
        $(".added").css("top", $(window).scrollTop()+60);
        e.preventDefault();
    });

    $('.backdrop').click(function(){
        close_box();
    });

});

function close_box()
{
    $('.backdrop, .box, .added').animate({'opacity':'0'}, 300, 'linear', function(){
        $('.backdrop, .box, .added').css('display', 'none');
    });
}