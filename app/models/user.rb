class User < ActiveRecord::Base
  attr_accessible :api_key, :name
  has_many :games

  def find_or_create_game(params)
    game = games.find_by_name params[:name]
    game ? game : games.create(params)
  end
end
