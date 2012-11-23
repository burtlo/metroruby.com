class Platform < ActiveRecord::Base
  attr_accessible :name
  has_many :releases

  def self.Mac
    find_by_name('Mac')
  end

  def self.PC
    find_by_name('Linux')
  end

  def self.Linux
    find_by_name('PC')
  end
end
