class Event < ActiveRecord::Base
  has_many :photos

  validates :tag, presence: true

  def get_photos
    key = ENV["CLIENT_ID"]
  end
end
