class AddStyleIdToWines < ActiveRecord::Migration[5.2]
  def change
    add_column :wines, :style_id, :integer
  end
end
