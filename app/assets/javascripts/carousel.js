function moveToRight(){
    $('#right_scroll').click(function() {
        $('#carousel_ul').animate({'marginLeft':'+=100%'}, 400, function(){
                $(this).find("li:last").after($(this).find("li:first"));
                $(this).css({marginLeft:0});
        });
    });
}
function moveToLeft(){
    $('#left_scroll').click(function() {
        $('#carousel_ul').animate({'marginLeft':'-=100%'}, 400, function(){
            $(this).find("li:last").after($(this).find("li:first"));
            $(this).css({marginLeft:0});
        });
    });
}

$(function() {
    moveToRight();
    moveToLeft();
});
