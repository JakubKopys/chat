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
//= require jquery.remotipart
//= require private_pub
//= require turbolinks
//= require_tree .

function ready() {

    //display lightbox on image click.
    //$(".post_thumb").click(function(e){
    // event delegation to attach events for dynamically loaded elements !!!
    $(this).on('click','.post_thumb', function(e){
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
    $(this).on('click','.backdrop', function(){
        close_box();
    });
    
    // delegate so it works after post form change afterr invalid submission.
    $(this).delegate('.post_image, #user_avatar', 'change', function(){
        var name = $(this).val().substr(12);

        //if statement prevents from showing empty button after canceling file chooser.
        if (name.length != 0) {
            $('.add .tooltip').html($(this).val().substr(12)); // substr(12) gets rid of C:/fakepath/ and leaves name of the file.
        }
        readURL(this);
    });

    $('.add').hide();

    //toggle new post form.
    $(".toggle").on('click', function(){
        $(".add").slideToggle(400, function() {
            if ($(this).is(":visible")) {
                $(".toggle").html('hide form');
                $(".toggle").animate({'margin': '0px 0 40px 0'}, 200);
            } else {
                $(".toggle").html('Add post');
                $(".toggle").animate({'margin': '40px 0'}, 200);
                $("ul#notice li").animate({'opacity': '0'}, 400, function() {
                    $("ul#notice").html('');
                });
            }
        });
    });


    //delegate - works with dynamically added posts
    $(this).delegate('.img_com_upl', 'change', function() {
        var className = $(this).attr('class').substr(12);
        readURL_comment(this, className);
    });

    $(this).delegate('.comment_area', 'keydown', function(e) {
        if(e.which == 13) {
            var h = $(this).height();
            var H = h += 20;
            var Hh = H.toString();
            $(this).css('height', Hh);
        }
    });

}


function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('.image_upload_preview, #avatar_preview').attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}
function readURL_comment(input, className) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('.'+className).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}


function close_box()  {
    $('.backdrop, .box, .added').animate({'opacity':'0'}, 300, 'linear', function(){
        $('.backdrop, .box, .added').css('display', 'none');
    });
}
//make sure js works despite using turbolinks - page:change and page:load events.
$(document).on('page:change', ready);
