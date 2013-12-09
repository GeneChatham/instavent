class Event < ActiveRecord::Base
  require 'date'

  has_many :photos

  validates :tag, presence: true

  MAX_SHOW = 25

  # def initialize
  #   @api_calls_array = []
  # end

  # def api_calls
  #   @api_calls_array
  # end

  def sort_photos
    sorted = self.photos.sort_by &:time
    sorted.reverse!  
  end

  def get_photos

    key = ENV["CLIENT_ID"]
    next_url = "https://api.instagram.com/v1/tags/#{self.tag}/media/recent?client_id=#{key}"
    count = 0
    event_start_time = Chronic.parse(self.start_time)
    event_end_time = Chronic.parse(self.end_time)
    @unix_created_time = 0
    @api_calls_array = []
    event_time_present = self.start_time.present? && self.end_time.present?


    while next_url && count < MAX_SHOW
      @api_calls_array << next_url
      response = Unirest.get(next_url)
      next_url = response.body["pagination"]["next_url"]
      response_array = response.body["data"]

      if event_time_present
        insta_array_earliest_time = response_array.last["created_time"].to_i
        # earliest_time = insta_array_last["created_time"]
        earilest_human_time = Time.at(insta_array_earliest_time)
        if earilest_human_time < event_end_time
          response_array.each do |data|
            if count < MAX_SHOW
              @unix_created_time = data["created_time"]
              human_time = Time.at(@unix_created_time.to_i)
              if human_time > event_start_time && human_time < event_end_time
                photo_save(data)
                count += 1
              end
            else
              break
            end         
          end
        end
      else
        response_array.each do |data|
          if count < MAX_SHOW
            @unix_created_time = data["created_time"]
            photo_save(data)
            count += 1
          else
            break
          end
        end         
      end
    end
  end

  def photo_save(data)
    photo = Photo.new
    photo.event_id = self.id
    photo.image = data["images"]["standard_resolution"]["url"]
    photo.time = @unix_created_time.to_i
    photo.caption = @api_calls_array.length
    photo.save

  end



end
      