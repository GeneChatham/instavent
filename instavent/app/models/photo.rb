class Photo < ActiveRecord::Base
  belongs_to :event

  validates :image, uniqueness: true


  

end
