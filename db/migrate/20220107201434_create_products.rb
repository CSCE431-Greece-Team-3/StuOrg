class CreateProducts < ActiveRecord::Migration[6.1]
    def change
      create_table :products do |t|
        t.string :title
        t.decimal :price
        t.integer :quantity
        t.references :user, foreign_key: true
  
        t.timestamps
      end
    end
  end