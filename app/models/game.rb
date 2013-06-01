class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, :through => :user_games

  before_create :set_defaults

  def set_defaults
    self.board ||= "123456789"
  end

  def set_board_at(position, label)
    board = self.board.dup
    board[position.to_i] = label
    self.board = board
  end

  def winner
    if winner_at?(0, 1, 2)
      board[0]
    elsif winner_at?(3, 4, 5)
      board[3]
    elsif winner_at?(6, 7, 8)
      board[6]
    elsif winner_at?(0, 3, 6)
      board[0]
    elsif winner_at?(0, 4, 8)
      board[0]
    elsif winner_at?(1, 4, 7)
      board[1]
    elsif winner_at?(2, 5, 8)
      board[2]
    elsif winner_at?(2, 4, 6)
      board[2]
    else
      nil
    end
  end

  def whose_turn
    x = board.count "X"
    o = board.count "O"
    if x >= o
      "O"
    else
      "X"
    end
  end

  private 

  def winner_at?(*positions)
    positions.map { |pos| board[pos] }.uniq.length == 1
  end

end

