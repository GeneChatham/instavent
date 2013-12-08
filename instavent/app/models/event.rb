class Event < ActiveRecord::Base
  has_many :photos

  validates :tag, presence: true

  def get_photos
    key = ENV["CLIENT_ID"]
    response = Unirest.get("https://api.instagram.com/v1/tags/#{self.tag}/media/recent?client_id=#{key}")
    response_array = response.body["data"]
    response_array.each do |data|
      photo = Photo.new
      photo.event_id = self.id
      photo.image = data["images"]["thumbnail"]["url"]
      photo.save
    end    
  end

end
