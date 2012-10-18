class AddExpiresAtToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :expires_at, :datetime
  end
end
