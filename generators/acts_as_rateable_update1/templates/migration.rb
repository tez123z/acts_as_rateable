class ActsAsRateableUpdate1Rename < ActiveRecord::Migration
  def self.up
    rename_table "rates", "old_rates"
    rename_table "ratings", "old_ratings"

    create_table "ratings" do |t|
      t.references "rateable",       :polymorphic => true, :nil => false
      t.float      "average_rating"
      t.timestamps
    end
    add_index "ratings", ["rateable_id", "rateable_type"]

    create_table "user_ratings" do |t|
      t.references "rating", :nil => false
      t.references "user",   :nil => false
      t.integer    "score",  :nil => false
      t.timestamps
    end
    add_index "user_ratings", ["user_id", "rating_id"]

    say_with_time "migrating exsting ratings" do
      connection.transaction do
        sql = "SELECT rateable_id, rateable_type, user_id, score FROM old_ratings INNER JOIN old_rates ON old_ratings.rate_id = old_rates.id"
        connection.select_all(sql).each do |row|
          rating = Rating.find_or_create_by_rateable_id_and_rateable_type(row['rateable_id'], row['rateable_type'])
          rating.user_ratings.find_or_create_by_user_id(:user_id => row['user_id'], :score => row['score'])
        end
        Rating.find(:all).each {|rating| rating.update_rating }
      end
    end

    drop_table "old_rates"
    drop_table "old_ratings"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover old ratings tables"
  end
end