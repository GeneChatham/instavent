class Event < ActiveRecord::Base
  has_many :photos

  validates :tag, presence: true

  MAX_SHOW = 50

  def get_photos
    key = ENV["CLIENT_ID"]
    next_url = "https://api.instagram.com/v1/tags/#{self.tag}/media/recent?client_id=#{key}"
    count = 0
    full = nil
    
    while next_url && !full
      response = Unirest.get(next_url)
      next_url = response.body["pagination"]["next_url"]
      response_array = response.body["data"]
      
      response_array.each do |data|
        if count < MAX_SHOW
          photo = Photo.new
          photo.event_id = self.id
          photo.image = data["images"]["thumbnail"]["url"]
          photo.save
          count += 1
        else
          full = true
        end
      end
    
    end

  
  end



end
