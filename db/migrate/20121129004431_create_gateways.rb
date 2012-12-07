class CreateGateways < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'gateways'
      create_table :gateways do |t|
        t.string :provider
        t.string :login
        t.string :password
        t.datetime :activated_at
        t.references :account
        t.string :mode
      end
    end
  end
end
