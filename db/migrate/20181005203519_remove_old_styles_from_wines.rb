class RemoveOldStylesFromWines < ActiveRecord::Migration[5.2]
  def change
    remove_column :wines, :old_style, :string
  end
end
