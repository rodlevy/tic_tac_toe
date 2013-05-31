$(document).ready(function() {
  document.getElementById("parent-list").addEventListener("click",function(e) {
    if(e.target && e.target.nodeName == "LI") {
      $.get('/game/gamestate', function(response){
        var whose_turn = response['whose_turn'];
        var board_state = response['board_state'];
        var current_user =response['current_user'];
      });
      if (whose_turn === current_user) {
        var li_number = e.target.id;
        if (user === 0){
          x = $('li#'+li_number).html('X');
          $(x).removeClass('btn-info').addClass('btn-warning');
          $('.container').removeClass('player_2').addClass('player_1');
        }
        else {
          O = $('li#'+li_number).html('O');
          $(O).removeClass('btn-info').addClass('btn-danger');
          $('.container').removeClass('player_1').addClass('player_2');
        }
        var square = e.target.id;
        var data = "{user:"+user+",response:"+square+"}";
        $.post('/game/square', data, function(response) {
          if (response['data'] === true) {
            $('.container').append('<h1> Player ' + (user +1 )+ ' has won! </h1>');
          }
        });
      }
    }
  });

});
