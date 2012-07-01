class CreateSingleSeats < ActiveRecord::Migration
  def change
    create_table :single_seats do |t|
      t.string :label
      t.decimal :x, :null => false, :default => 0.0
      t.decimal :y, :null => false, :default => 0.0
    end
  end
end
