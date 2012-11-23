class Game < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :user
  has_many :releases

  def release_for(platform)
    releases.find_by_platform_id(platform.id)
  end
end
