class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.references :user
      t.references :game
      t.string :label
      t.timestamps
    end
  end
end
