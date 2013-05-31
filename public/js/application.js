$(document).ready(function() {
  document.getElementById("parent-list").addEventListener("click",function(e) {
    if(e.target && e.target.nodeName == "LI") {
      $.get('/game/gamestate/'+$('#parent-list').data('game_id'), function(response){
        var your_turn = response['your_turn'];
        var your_label =response['your_label'];
        
        if (your_turn === true) {
          var li_number = e.target.id;
          x = $('li#'+li_number).html(your_label);
          $(x).removeClass('btn-info').addClass('btn-warning');
          $('.container').removeClass('player_2').addClass('player_1');

          var square = e.target.id;
          var data = "{user:"+your_label+",response:"+square+"}";
          $.post('/game/update/'+$('#parent-list').data('game_id'), data, function(response) {
            if (response['data'] === true) {
              $('.container').append('<h1> Player ' + (your_label +1 )+ ' has won! </h1>');
            }
          });
        }
      });
    }
  });
});



