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

function ready() {

    $('.add').hide();
    //display lightbox on image click.
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

    //close lightbox after clicking outseide of it.
    $('.backdrop').click(function(){
        close_box();
    });

    //After choosing img to upload change button content to img name.
    $('#post_image, #user_avatar').change(function(){
        var name = $(this).val().substr(12);

        //if statement prevents from showing empty button after canceling file chooser.
        if (name.length != 0) {
            $('.tooltip').html($(this).val().substr(12)); // substr(12) gets rid of C:/fakepath/ and leaves name of the file.
        }
    });

    //toggle new post form.
    $(".toggle").click(function(){
        $(".add").slideToggle(400, function() {
            if ($(this).is(":visible")) {
                $(".toggle").html('hide form');
                $(".toggle").animate({'margin': '0px 0 40px 0'}, 200);
            } else {
                $(".toggle").html('Add post');
                $(".toggle").animate({'margin': '40px 0'}, 200);
            }
        });
    });
}

function close_box()  {
    $('.backdrop, .box, .added').animate({'opacity':'0'}, 300, 'linear', function(){
        $('.backdrop, .box, .added').css('display', 'none');
    });
}

//make sure js works despite using turbolinks - page:change and page:load events.
$(document).on('page:change', ready);
//$(document).on('page:load', ready);