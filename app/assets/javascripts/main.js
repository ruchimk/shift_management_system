function animate_popup() {
    // On main image hover, animate the popup
    $("#users_profile_image").hover(function() {
        $('.signin_popup').animate({
            opacity: 1,
            "marginTop": "-20px"
        }, 1000);
    });

    $(".abort").click(function() {
        $('.signin_popup').animate({
            opacity: 0,
            "marginTop": "20px"
        }, 500);
    });
}

function animate_slogan() {
    var boxes = $('.box');
    boxes.css({
        opacity: 0
    })
    boxes.each(function(i, box) {
        setTimeout(function() {
            $(box).addClass("animated fadeInDownBig");
        }, i * 500);
    });
}


function check(form) { /*function to check userid & password*/
    /*the following code checkes whether the entered userid and password are matching*/
    if (form.userid.value == "myuserid" && form.pswrd.value == "mypswrd") {
        window.open('target.html') /*opens the target page while Id & password matches*/
    } else if (form.userid.value == "" && form.pswrd.value == "") {
        alert("What are you waiting for? \nat least give it a try!")
    } else {
        alert("Error Password or Username! \nplease try again!"); /*displays error message*/
    };
}

// function addDate(){
//     $('#newShift').click(function(){
//         $('.shiftTemplateForm').slideUp('slow' , function(){
//         });
//     });
// }

$(function() {
    animate_popup();
    animate_slogan();
    // addDate();
});


// ------------------------------------------------------------

// $(window).load(function() {
//     var box = $(".box");
//     for (var i = 0; i < box.length; i++) {
//         $(box[i]).fadeOut('slow');
//     };
// });


var poster = $(".poster");
function runIt(){
    poster.addClass("animated bounceIn");
}

function check(form) { /*function to check userid & password*/
    /*the following code checkes whether the entered userid and password are matching*/
    if (form.userid.value == "myuserid" && form.pswrd.value == "mypswrd") {
        window.open('target.html') /*opens the target page while Id & password matches*/
    } else if (form.userid.value == "" && form.pswrd.value == "") {
        alert("What are you waiting for? \nat least give it a try!")
    } else {
        alert("Error Password or Username! \nplease try again!"); /*displays error message*/
    };
}
