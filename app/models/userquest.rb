class Userquest < ActiveRecord::Base
  belongs_to :user
  belongs_to :quest
  
  paginates_per 3
end
