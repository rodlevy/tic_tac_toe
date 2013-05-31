class Game < ActiveRecord::Base
  has_and_belong_to_many :players
end
