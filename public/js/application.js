$(document).ready(function() {
  $('.container').on("click",'#parent-list',function(e) {
    if(e.target && e.target.nodeName == "LI") {
      $.get('/game/gamestate/'+$('#parent-list').data('game_id'), function(response){
        var your_turn = response['your_turn'];
        var your_label =response['your_label'];
        
        if (your_turn === true) {
          var li_number = e.target.id;
          x = $('li#'+li_number).html(your_label);

          var square = e.target.id;
          var data = {'label':your_label, 'square': square};
          $.post('/game/update/'+$('#parent-list').data('game_id'), data, function(response) {
          });
        }
        else {
          $('#parent-list').before('<p> Not your Turn!</p>');
        }
      });
    }
  });

  var interval = setInterval(function() {
    $.get('/game/changed/'+$('#parent-list').data('game_id'), function(response){
      if (response['data'] === response.your_label) {
        $('nav').append('<h1> You won! </h1>');
        clearInterval(interval);
        $('.container').unbind('click');
      }
      else if (response['data'] !== null) {
        $('nav').append('<h1> You lost! </h1>');
        clearInterval(interval);
        $('.container').unbind('click');
      }
      else if (response.tie === null) {
        $('nav').append('<h1> You Tied! </h1>');
        clearInterval(interval);
        $('.container').unbind('click');
     }
     $('.game').replaceWith(response.page);
   });
  }, 2500);
});
