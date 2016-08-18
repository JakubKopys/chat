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
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require private_pub
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    if ($('.pagination').length) {
        $(window).scroll(function() {
            var url = $('.pagination .next_page').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $('.pagination').text("Please Wait...");
                return $.getScript(url);
            }
        });
        return $(window).scroll();
    }
    $('input').click(function()
    {
        $(this).attr('placeholder','');

    });

});


function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('.image_upload_preview, #avatar_preview, .edit_post_prev').attr('src', e.target.result);
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

$(document).delegate('.toggle_replies', 'click', function(e) {
    e.preventDefault();
    var data_id = $(this).data('id');
    $('.replies_'+data_id).toggle();
});

$(document).delegate('.comment_area', 'keydown', function(e) {
    if(e.which == 13) {
        var h = $(this).height();
        var H = h += 20;
        var Hh = H.toString();
        $(this).css('height', Hh);
    }
});

//delegate - works with dynamically added posts
$(document).delegate('.img_com_upl, .comment_image', 'change', function() {
    var className = $(this).attr('class').substr(12);
    readURL_comment(this, className);
});

$(document).delegate('.edit_post_image', 'change', function() {
    readURL(this);
});


// delegate so it works after post form change afterr invalid submission.
$(document).delegate('.post_image, #user_avatar', 'change', function(){
    var name = $(this).val().substr(12);

    //if statement prevents from showing empty button after canceling file chooser.
    if (name.length != 0) {
        $('.add .tooltip').html($(this).val().substr(12)); // substr(12) gets rid of C:/fakepath/ and leaves name of the file.
    }
    readURL(this);
});