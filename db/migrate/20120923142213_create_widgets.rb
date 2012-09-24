class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :slug
      t.string :title
      t.integer :account_id
      
      t.text :body

      t.timestamps
    end
  end
end
