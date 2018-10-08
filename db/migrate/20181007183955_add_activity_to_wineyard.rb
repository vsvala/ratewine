class AddActivityToWineyard < ActiveRecord::Migration[5.2]
  def change
    add_column :wineyards, :active, :boolean
  end
end
