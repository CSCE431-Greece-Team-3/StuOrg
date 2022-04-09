class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :username
      t.string :password_digest
      t.string :first
      t.string :last
      t.string :organizations
      t.belongs_to :users, foreign_key: true
      
      t.timestamps
    end
  end
end
