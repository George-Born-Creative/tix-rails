class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :name
      t.string :background_image_url

      t.timestamps
      
    end
  end
end


