class AddTimeToPhotoTable < ActiveRecord::Migration
  def change
  	add_column(:photos, :time, :integer)
  end
end
