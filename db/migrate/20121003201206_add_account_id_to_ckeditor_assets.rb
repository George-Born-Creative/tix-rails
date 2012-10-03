class AddAccountIdToCkeditorAssets < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :account_id, :integer
  end
end
