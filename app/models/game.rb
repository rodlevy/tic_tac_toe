class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, :through => :user_games

  def self.create(params = {})
    @board = "000000000"
    @game = Game.new(:board => @board)
    @game.save
    @game
  end


  def self.update_board!(game_id, player_position, player_id)
    self.find(game_id)[player_position] = player_id
  end

  def self.winner?(player_position, player_id)
    if @board[0] && @board[1] && @board[2] == player_id
      return player_id
    elsif @board[3] && @board[4] && @board[5] == player_id
      return player_id
    elsif @board[6] && @board[7] && @board[8] == player_id
      return player_id
    elsif @board[0] && @board[3] && @board[6] == player_id
      return player_id
    elsif @board[0] && @board[4] && @board[8] == player_id
      return player_id
    elsif @board[1] && @board[4] && @board[7] == player_id
      return player_id
    elsif @board[2] && @board[5] && @board[8] == player_id
      return player_id
    elsif @board[2] && @board[4] && @board[6] == player_id
      return player_id
    else
      return nil
    end
  end
end

