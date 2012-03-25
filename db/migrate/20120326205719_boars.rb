class CreateBoars < ActiveRecord::Migration
  def up
    create_table :boars, :force => true do |t|
      t.string :id
      t.string :title,          :null => false, :default => ""
      t.string :rating,         :default => "0"
      t.string :status,         :default => "novice"
      t.boolean :active,        :default => "t"
      t.string :comment,        :default => ""
      t.string :source,         :default => ""
      t.string :aliases,        :default => ""
      t.string :hunter_id,      :null => false
      t.string :searched_by,    :default => ""
      t.string :category,       :default => ""
      t.string :crunchbase_url, :default => ""
      t.string :seed_date,      :default => ""
      t.string :A_date,         :default => ""
      t.string :B_date,         :default => ""
      t.string :C_date,         :default => ""
      t.string :un_date,        :default => ""
      t.string :employees,      :default => "0"
      t.string :fund,           :default => ""
      t.string :ceo,            :default => ""
      t.string :cto,            :default => ""
      t.string :founder,        :default => ""
      t.text :overview,         :default => ""
      
      # Add fields that let Rails automatically keep track
      # of when companies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :boars
  end
 
end
