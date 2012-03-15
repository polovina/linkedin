class CreateBoars < ActiveRecord::Migration
  def up
    create_table :boars do |t|
      t.string :id
      t.string :title
      t.string :rating
      t.string :status
      t.boolean :active
      t.text :description
      t.string :comment
      t.string :source
      t.string :aliases
      # Add fields that let Rails automatically keep track
      # of when companies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :boars
  end
 
end
