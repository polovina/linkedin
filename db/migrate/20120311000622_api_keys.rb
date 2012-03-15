class ApiKeys < ActiveRecord::Migration
  def up
    create_table :apikeys do |t|
      t.string :token
      t.string :secret
    end
  
  end
  def down
    drop_table :apikeys
  end
end
