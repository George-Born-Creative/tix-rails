class AddNewsletterOptInToUser < ActiveRecord::Migration
  def change
    add_column :users, :newsletter_opt_in, :boolean, :default => false
  end
end
