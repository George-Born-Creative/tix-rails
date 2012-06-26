class CreateAreaSeats < ActiveRecord::Migration
  def change
    create_table :area_seats do |t|
      t.string :polypath
      t.string :label
    end
  end
end
