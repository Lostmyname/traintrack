class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.float :budget
      t.float :remaining
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
