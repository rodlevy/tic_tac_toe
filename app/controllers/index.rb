get '/' do
  erb :index
end


post '/game/update/:game_id' do
  game = current_user.games.find(params[:game_id])
  game.set_board_at(params[:square], params[:label])
  game.save
  content_type :json
  {:data => game.winner }.to_json
end


get "/game/new" do
  @game = Game.create
  @user_game = UserGame.create(:game_id => @game.id, :user_id => current_user.id, :label => 'X')
  redirect "/game/#{@game.id}"
end

get "/game/join_game/:game_id" do
  @game = Game.find(params[:game_id])
  UserGame.create(:game_id => @game.id, :user_id => current_user.id, :label => 'O')
  redirect "/game/#{@game.id}"
end

get '/game/changed/:game_id' do
 @game = Game.find(params[:game_id])
 user_label = UserGame.find_by_game_id_and_user_id(@game.id, current_user.id).label
 @game.winner == user_label 
 @game.winner != nil
 content_type :json
{:page => (erb :current_game, :layout => false), :data => @game.winner, :your_label => user_label}.to_json
end

get "/game/:game_id" do
  @game = Game.find(params[:game_id]) 
  erb :current_game
end

get '/game/gamestate/:game_id' do
  game = Game.find(params[:game_id])
  user_label = UserGame.find_by_game_id_and_user_id(game.id, current_user.id).label
  if game.whose_turn == user_label
    your_turn = true
  else
    your_turn = false
  end
  content_type :json
  {:your_turn => your_turn, :your_label => user_label}.to_json
end

