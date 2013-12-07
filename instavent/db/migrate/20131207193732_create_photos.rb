class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :tag
      t.string :type
      t.text :location
      t.text :caption
      t.text :image
      t.integer :event_id

      t.timestamps
    end
  end
end
