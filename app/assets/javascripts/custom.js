$(document).on('turbolinks:load', function() {

  // dont think i need this function wrapper for this datepicker
  $( function() {
    $( ".datepicker" ).datepicker();
    //TODO come back to this and check if it's the correct format
    //$('#datepicker').datepicker({ dateFormat: 'dd-mm-yy' });
  } );

  $(document).ready($(".en").select2());

  $(function() {
    $('#main-menu').smartmenus({
      mainMenuSubOffsetX: -1,
      mainMenuSubOffsetY: 4,
      subMenusSubOffsetX: 6,
      subMenusSubOffsetY: -6
    });
  });
});

function show(comment_id) {
  var $button_id = "#"+"edit_" + comment_id
  $("#" + comment_id).toggle();
  $($button_id).text($($button_id).text() == 'Edit' ? "Cancel" : "Edit" ); // <- HERE
  return false;
};





// function preview(x){
//   //document.getElementById("smiles").src = x.value;
//   Y = document.getElementById('post_pic').files[0].src;
//   alert(Y);
//
//
//   var input = document.getElementById("post_pic");
//   var fReader = new FileReader();
//   fReader.readAsDataURL(input.files[0]);
//   fReader.onloadend = function(event){
//   var img = document.getElementById("smiles");
//   img.src = event.target.result;
//   // http://stackoverflow.com/questions/4851595/how-to-resolve-the-c-fakepath
//   //https://blueimp.github.io/jQuery-File-Upload/index.html
// }
//}




function test(){

/* alert("Hi there"); */
/* https://www.sitepoint.com/use-jquerys-ajax-function/ */
/* http://stackoverflow.com/questions/29324852/allow-cors-in-ruby-on-rails*/
/* http://api.jquery.com/jquery.ajax/ */
/* http://stackoverflow.com/questions/10456240/jquery-ajax-call-return-json-parsing-error */
/* does rails do CORS ?*/
/*https://www.reddit.com/r/rails/comments/3k3jj7/help_does_ajax_post_already_contain_csrf_token_in/ */
/* http://mark.nadigs.net/2012/10/16/rails-and-cross-origin-resource-sharing-cors/ */
/* http://excid3.com/blog/rails-tip-2-include-csrf-token-with-every-ajax-request */
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});




//document.getElementById('test').innerHTML = "test 1"




 // var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );
 // $.ajaxSetup( {
 //     beforeSend: function ( xhr ) {
 //       xhr.setRequestHeader( 'X-CSRF-Token', token );
 //     }
 //   });

$.ajax({

   /* url: 'http://api.joind.in/v2.1/talks/10889', */
   url: 'http://localhost:3000/users/1.json',
   contentType: "json",
   crossDomain: true,
   //data: {
  //    format: 'json'
   //},
   error: function(data,textStatus,what) {
     alert("error" + data.responseText);
   },
   dataType: 'html',
   success: function(data, textStatus, other) {
     //var returnedData = JSON.parse(data);
     console.log(data[3]);

     var returnedData =  $.parseJSON ( data );
     alert(returnedData["id"]);
     alert(returnedData["email"]);
     alert("success " + data)

     var elem = document.createElement("img");
     var elem2 = document.createElement("select");
     elem.src = 'http://localhost:3000/1/photo/thumb/1/pic/serve_image';
     var theDiv = document.getElementById("test");
     theDiv.appendChild(elem);
     theDiv.appendChild(elem2);



     var langArray = [
         {value: "val1", text: "text 1"},
         {value: "val2", text: "text 2"}
     ];


     var select = document.createElement('select'),
    option,
    i = 0,
    il = langArray.length;
    select.className="en";


for (; i < il; i += 1) {
    option = document.createElement('option');
    option.setAttribute('value', langArray[i].value);
    option.appendChild(document.createTextNode(langArray[i].text));
    select.appendChild(option);
}

theDiv.appendChild(select);




    //  alert(data.talks[0].start_date)
    //  alert(data.talks[0].talk_title)
    //  console.debug();
    //  console.log("hi there")
   },
   type: 'GET'
});

};
