class RenameColumnInSpots < ActiveRecord::Migration[6.1]
  def change
    rename_column(:spots, :type, :category)
  end
end
