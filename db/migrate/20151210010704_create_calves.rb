class CreateCalves < ActiveRecord::Migration
  def change
    create_table :calves do |t|
      t.belongs_to :cow
      t.string :name
      t.integer :age
      t.float :money
      t.string :country
      t.references :cow, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end