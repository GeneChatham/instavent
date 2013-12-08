class Event < ActiveRecord::Base
  require 'date'

  has_many :photos

  validates :tag, presence: true

  MAX_SHOW = 10

  def get_photos

    key = ENV["CLIENT_ID"]
    next_url = "https://api.instagram.com/v1/tags/#{self.tag}/media/recent?client_id=#{key}"
    count = 0
    full = nil
    human_start_time = Chronic.parse(self.start_time)
    human_end_time = Chronic.parse(self.end_time)
    @unix_created_time = 0


    while next_url && !full
      response = Unirest.get(next_url)
      next_url = response.body["pagination"]["next_url"]
      response_array = response.body["data"]
      
      response_array.each do |data|
        if count < MAX_SHOW
          if self.start_time.present? && self.end_time.present?
            @unix_created_time = data["created_time"]
            human_time = Time.at(@unix_created_time.to_i)
            if human_time > human_start_time && human_time < human_end_time
              photo_save(data)
              count += 1
            end
          
          else
            photo_save(data)
            count += 1            
          end
        else
          full = true
        end
      end
    end
  end

  def photo_save(data)
    photo = Photo.new
    photo.event_id = self.id
    photo.image = data["images"]["thumbnail"]["url"]
    photo.time = @unix_created_time.to_i
    photo.save

  end

end
      