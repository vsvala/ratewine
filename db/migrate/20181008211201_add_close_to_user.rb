class AddCloseToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :close, :boolean
  end
end
