get '/' do
  erb :index
end

post '/game/square' do
content_type :json
{:data => false }.to_json
end



# get 'game/gamestate' do
  
#   your_turn?
#   current_user.id == Game.where(who has less squares picked)

#   content_type :json
#   {:current_user, :whose_turn, :gamestate}.to_json
# end


get "game/new" do
  @game = Game.create
  @user_game = UserGame.create(:game_id => @game.id, :user_id => current_user.id)
  redirect "/game/#{@game.id}"
end

get "game/join_game/:game_id" do
  @game = Game.find(params[:game_id])
  @user_game = UserGame.create(:game_id => @game.id, :user_id => current_user.id)
  erb :game
end
