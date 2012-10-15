class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.text :css_doc
      t.datetime :activated_at

      t.timestamps
    end
  end
end
