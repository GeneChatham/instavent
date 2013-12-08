class Photo < ActiveRecord::Base
  belongs_to :event

# ensures no duplication of images in data table
  validates :image, uniqueness: true


  

end
