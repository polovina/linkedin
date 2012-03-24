class CreateShots < ActiveRecord::Migration
  def up
    create_table :shots do |t|
      t.string :id
      t.string :boar
      t.string :hunter
      t.string :connection_first
      t.string :connection_first_url
      t.string :connection_second
      t.string :connection_second_url
      t.string :headline
      t.string :source
      t.string :comments
      t.boolean :important
      t.string :hunter_id
      t.string :boar_id
      # Add fields that let Rails automatically keep track
      # of when records are added or modified:
      t.timestamps
    end
  end
  def down
    drop_table :shots
  end
end
