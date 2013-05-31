$(document).ready(function() {
  var user = 0;
  document.getElementById("parent-list").addEventListener("click",function(e) {
    if(e.target && e.target.nodeName == "LI") {
          var li_number = e.target.id;
      if (user === 0){
          $('li#'+li_number).html('X');
        }
      else {
        $('li#'+li_number).html('O');
      }
      var square = e.target.id;
      var data = "{user:"+user+",response:"+square+"}";
      $.post('/game/square', data, function(response) {
        if (response['data'] === true) {
          $('.container').append('<h1> Player ' + (user +1 )+ ' has won! </h1>');
        }
        else {
          if (user === 0){
            user = 1;
          }
          else {
            user = 0;
          }
        }
      });
    }
  });

});
