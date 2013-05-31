class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, :through => :user_games

  
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.create(params={})
    @user = User.new(:email => params[:email], :name => params[:name])
    @user.password = params[:password]
    @user.save!
    @user
  end

  def self.authenticate(params)
    user = User.find_by_name(params[:name])
    (user && user.password == params[:password]) ? user : nil
  end
end
