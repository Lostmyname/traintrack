class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.text :name
      t.datetime :date
      t.float :cost
      t.text :url
      t.text :notes
      t.text :status
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
