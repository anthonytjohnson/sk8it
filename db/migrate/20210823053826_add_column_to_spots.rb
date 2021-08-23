class AddColumnToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :description, :string
  end
end
