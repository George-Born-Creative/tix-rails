class AddMethodAndOrginToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_method_name, :string
    add_column :orders, :payment_origin_name, :string
  end
end
