class Event < ActiveRecord::Base
  require 'date'

  has_many :photos

  validates :tag, presence: true

  MAX_SHOW = 50

  def get_photos
    # self.start_time << 1386464454
    # self.end_time << 1386467058 
    # self.save
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
          unix_created_time = data["created_time"]
          human_time = Time.at(unix_created_time.to_i)
          if self.start_time && self.end_time
            if human_time > Chronic.parse(self.start_time) && human_time < Chronic.parse(self.end_time) 
              photo.save
              count += 1
            end
          else
            photo.save
            count += 1
          end
        else
          full = true
        end
      end
    
    end

  end

end
