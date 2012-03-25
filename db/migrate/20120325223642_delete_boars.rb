class DeleteBoars < ActiveRecord::Migration
  def up
  drop_table :boars
  end

  def down
  end
end
