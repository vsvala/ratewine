# frozen_string_literal: true

class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :style
      t.integer :wineyard_id

      t.timestamps
    end
  end
end
