// $("document").ready(function(){
//   $("#button").on("click", function(){
//     close();
//   });
// });

// function open(){
//   console.log(1);
//   $('.close_bar').fadeIn();
// };

// function close(){
//   console.log(1);
//   $('.close_bar').hide();
// };

$(function () {
    var $body = $('body');

    //開閉用ボタンをクリックでクラスの切替え
    $('#js__btn').on('click', function () {
        $body.toggleClass('open');
    });

    //メニュー名以外の部分をクリックで閉じる
    $('#js__nav').on('click', function () {
        $body.removeClass('open');
    });
});