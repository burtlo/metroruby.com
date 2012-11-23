class Release < ActiveRecord::Base
  attr_accessible :version, :platform, :game
  belongs_to :game
  belongs_to :platform
end
