module ActiveRecord
  module Acts
    module Rateable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_rateable(options = {})
          has_one :rating, :as => :rateable, :dependent => :destroy

          unless respond_to?(:max_rating)
            class_inheritable_accessor :max_rating
            attr_protected :max_rating
            self.max_rating = options[:max_rating] || 5
          end

          include ActiveRecord::Acts::Rateable::InstanceMethods
        end
      end

      module InstanceMethods
        # Rates the object by a given score. A user object should be passed to the method.
        def rate_it(score, user)
          create_rating unless rating
          rating.rate(score, user)
        end

        # Calculates the average rating. Calculation based on the already given scores.
        def average_rating
          rating && rating.average_rating || 0.0
        end

        # Rounds the average rating value.
        def average_rating_round
          average_rating.round
        end

        # Returns the average rating in percent.
        def average_rating_percent
          f = 100 / max_rating.to_f
          average_rating * f
        end

        # Checks whether a user rated the object or not.
        def rated_by?(user)
          rating.user_ratings.exists?(:user_id => user)
        end

        # Returns the rating a specific user has given the object.
        def rating_by(user)
          user_rating = rating.user_ratings.find_by_user_id(user.id)
          user_rating ? user_rating.score : nil
        end

      end

    end
  end
end
