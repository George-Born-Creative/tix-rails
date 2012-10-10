class CreateCarouselItems < ActiveRecord::Migration
  def change
    create_table :carousel_items do |t|
      t.string :title
      t.string :caption
      t.string :link

      t.timestamps
    end
  end
end
