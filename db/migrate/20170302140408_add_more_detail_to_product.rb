class AddMoreDetailToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :datetime, :datetime
    add_column :products, :location, :string
  end
end
