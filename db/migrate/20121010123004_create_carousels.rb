class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :slug
      t.references :account
      t.timestamps
    end
  end
end
