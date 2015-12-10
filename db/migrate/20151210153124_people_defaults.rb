class PeopleDefaults < ActiveRecord::Migration
  def change
    change_column :people, :budget, :float, default: 1000
    change_column :people, :remaining, :float, default: 1000
    change_column :people, :admin, :boolean, default: false
  end
end
