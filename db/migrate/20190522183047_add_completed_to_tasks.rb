class AddCompletedToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :completed, :boolean, null: false, default: false
  end
end
