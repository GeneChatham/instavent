class Event < ActiveRecord::Base
  has_many :photos

  validates :tag, presence: true
end
