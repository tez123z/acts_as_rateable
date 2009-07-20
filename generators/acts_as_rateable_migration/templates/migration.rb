class ActsAsRateableMigration < ActiveRecord::Migration
  def self.up
    
    create_table :ratings do |t|
      t.references :rateable, :polymorphic => true
      t.references :user
      t.integer :score
      t.timestamps
    end
    
    add_index :ratings, [:rateable_id, :rateable_type]
  end
  
  def self.down
    drop_table :ratings
  end
end
