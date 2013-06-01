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

          var square = e.target.id;
          var data = {'label':your_label, 'square': square};
          $.post('/game/update/'+$('#parent-list').data('game_id'), data, function(response) {
            if (response['data'] === your_label) {
              $('.container').append('<h1> Player ' + your_label+ ' has won! </h1>');
            }
          });
        }
      });
    }
  });
});



