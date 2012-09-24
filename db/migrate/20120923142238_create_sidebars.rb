class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.string :slug
      t.string :title
      t.references :account
      t.timestamps
    end
  end
end
