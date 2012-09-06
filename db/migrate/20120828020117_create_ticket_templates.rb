class CreateTicketTemplates < ActiveRecord::Migration
  def change
    create_table :ticket_templates do |t|
      t.string :label
      t.string :meta
      t.integer :times_used, :null => false, :default => 0
      t.references :account
      t.timestamps
    end
    
    
    add_column :ticket_templates, :file_file_name, :string
    add_column :ticket_templates, :file_content_type, :string
    add_column :ticket_templates, :file_file_size, :integer
    add_column :ticket_templates, :file_updated_at, :datetime
    
  end
end
