var count = 1;
$("document").ready(function(){
    $(".fileinput").change(fileInputChange);
});

function fileInputChange(){
    if($(".fileinput").last().val() != ""){
        $("#filelist").append('<input class="fileinput" accept="image/*" type="file" name="product[productimages_attributes][' + count + '][image_url]" id="product_productimages_attributes_' + count + '_image_url"><br>').bind('change', fileInputChange);
        count ++;
    };
};


var cnt = 0;
function aaa(){
  $("#pic").on("click", function() {
    $(_destroy).attr(value, 'true');
    console.log('hoge');
    cnt++;
  });
};