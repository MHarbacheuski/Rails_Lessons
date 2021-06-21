class ItemsOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :items_orders,id:false do |f|
      f.belongs_to :item
      f.belongs_to :order
    end
  end
end
