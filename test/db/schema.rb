ActiveRecord::Schema.define(:version => 0) do

  create_table :users, :force => true do |t|
    t.column :name, :text
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type", :limit => 32
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table :books, :force => true do |t|
    t.column :title, :text
  end

  create_table :videos, :force => true do |t|
    t.column :title, :text
  end
  
end
