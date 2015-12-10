class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :calf
      t.string :title
      t.text :body
      t.integer :rating
      t.timestamps null: false
    end
  end
end
