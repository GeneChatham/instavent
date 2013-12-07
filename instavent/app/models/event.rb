class Event < ActiveRecord::Base
  has_many :photos

  validates :tag, presence: true

  def get_photos
    key = ENV["CLIENT_ID"]
    response = Unirest.get("https://api.instagram.com/v1/tags/mkshackathon/media/recent?client_id=#{key}")
    photo = Photo.new
    photo.event_id = self.id
    photo.image = response.body["data"][2]["images"]["standard_resolution"]["url"]
    photo.save    
  end

end
