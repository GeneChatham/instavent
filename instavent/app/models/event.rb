class Event < ActiveRecord::Base
  require 'date'

  has_many :photos

  validates :tag, presence: true

  def get_photos
    # self.start_time << 1386464454
    # self.end_time << 1386467058 
    # self.save
    key = ENV["CLIENT_ID"]
    response = Unirest.get("https://api.instagram.com/v1/tags/#{self.tag}/media?client_id=#{key}")
    response_array = response.body["data"]
    response_array.each do |data|
      photo = Photo.new
      photo.event_id = self.id
      photo.image = data["images"]["low_resolution"]["url"]

     # Add time range search within loop
      unix_created_time = data["caption"]["created_time"]
      human_time = Time.at(unix_created_time.to_i)
      # time_start = 1386464454
      # time_end = Time.now.to_i
        # unix_start_time = self.start_time
        # unix_end_time = self.end_time

      if human_time > Chronic.parse(self.start_time) && human_time < Chronic.parse(self.end_time) 
        photo.save
      end    
    end
  end


end
