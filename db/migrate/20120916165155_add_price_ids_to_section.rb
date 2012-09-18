class AddPriceIdsToSection < ActiveRecord::Migration
  def change
    add_column :sections, :dayof_price_id, :integer
    add_column :sections, :presale_price_id, :integer
    remove_column :prices, :section_id
    
  end
end
