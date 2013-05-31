class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :password_hash
      t.integer   :wins
      t.integer   :ties
      t.integer   :games
      t.timestamps
    end
  end
end
