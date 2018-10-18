class AddConfirmToMemberhip < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :confirm, :boolean
  end
end
