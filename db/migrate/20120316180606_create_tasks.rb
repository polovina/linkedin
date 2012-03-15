class CreateTasks < ActiveRecord::Migration
   def up
    create_table :tasks do |t|
      t.string :id
      t.string :task
      t.string :frequency
      t.boolean :active
      t.string :description
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end
  def down
    drop_table :tasks
  end
end
