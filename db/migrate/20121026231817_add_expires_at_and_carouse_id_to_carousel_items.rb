class AddExpiresAtAndCarouseIdToCarouselItems < ActiveRecord::Migration
  def change
    add_column :carousel_items, :expires_at, :datetime
    add_column :carousel_items, :index, :integer
    add_column :carousel_items, :carousel_id, :integer
  end
end
