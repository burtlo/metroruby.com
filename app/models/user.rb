class User < ActiveRecord::Base
  attr_accessible :api_key, :name
end
