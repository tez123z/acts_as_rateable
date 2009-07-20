class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  has_many :user_ratings

  delegate :max_rating, :to => :rateable

  def rate(score, user)
    user_ratings.find_or_initialize_by_user_id(user.id).update_attributes!(:score => score)
    reload
  end

  # Call this method the update the avarage rating; you don't normally need to
  # do this manually, saving or updating a user rating already takes care of
  # updating the avarage rating.
  def update_rating
    self.average_rating = user_ratings.average(:score)
    save!
  end

  private

  def max_rating_allowed_by_parent
    if score < 1
      errors.add(:score, "must be greater than or equal to 1")
    elsif score > max_rating
      errors.add(:score, "must be less than or equal to #{max_rating}")
    end
  end

end
