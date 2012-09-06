# From http://railsforum.com/viewtopic.php?id=5882 
class CreatePhonesAndAddresses < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :phonable_id, :integer, :null => false
      t.column :phonable_type, :string, :null => false
      t.column :tag_for_phone, :string # could be "work phone", "home phone", etc
      t.column :number, :string # redundant but makes searching easier
      t.column :country_code, :string
      t.column :locality_code, :string # in the US, "area code", elsewhere "city code"
      t.column :local_number, :string
    end
    create_table :addresses do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :addressable_id, :integer, :null => false
      t.column :addressable_type, :string, :null => false
      t.column :tag_for_address, :string # could be "mailing address", "shipping address", etc
      t.column :country, :string
      
      
      t.column :address_line_1, :string 
      t.column :address_line_2, :string
      t.column :locality, :string # in the US, "city"
      t.column :admin_area, :string # in the US, "state", not using state 
      t.column :postal_code, :string
    end
    add_index :phones, :number # don't make this unique!
    add_index :addresses, :address_line_1 # don't make this unique!
    add_index :addresses, :postal_code # don't make this unique!
    
  end
  
  
  def self.down
    drop_table :phones
    drop_table :addresses
  end
  
  
end