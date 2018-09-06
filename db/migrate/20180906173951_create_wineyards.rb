class CreateWineyards < ActiveRecord::Migration[5.2]
  def change
    create_table :wineyards do |t|
      t.string :name
      t.integer :year

      t.timestamps
    end
  end
end
