class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :content, :theme
  
  searchable do
    string :title
  end
  
  paginates_per 3
end
