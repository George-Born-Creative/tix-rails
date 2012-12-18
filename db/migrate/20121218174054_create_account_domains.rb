class CreateAccountDomains < ActiveRecord::Migration
  def change
     create_table :account_domains do |t|
        t.string :domain, :null => false, :unique => true
        t.integer :account_id, :null => false
        t.timestamps
      end
      
      add_index :account_domains, :account_id
      add_index :account_domains, :domain, :unique => true
  end
end