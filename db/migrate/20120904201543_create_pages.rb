class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug, :null => false
      t.string :title, :null => false
      t.text :body
      t.integer :account_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
