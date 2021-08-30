class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :file_data
      t.references :video_category

      t.timestamps
    end
  end
end
