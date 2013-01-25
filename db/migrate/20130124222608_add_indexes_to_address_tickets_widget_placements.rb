class AddIndexesToAddressTicketsWidgetPlacements < ActiveRecord::Migration
  def change
    add_index "addresses", [:addressable_id, :addressable_type], :name => "by_addressable_id_and_type"
    add_index "phones", [:phonable_id, :phonable_type], :name => "by_phonable_id_and_type"
    add_index "tickets", [:order_id], :name => "by_order_id"
    add_index "widget_placements", [:widget_id, :sidebar_id], :name => "by_widget_and_sidebar"
  end
end

