require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class ActsAsRateableTest < ActiveSupport::TestCase

  test "rate_it one user" do
    books(:alice).rate_it(4, users(:john))
    assert_equal 4.0, books(:alice).average_rating
    assert_equal 4, books(:alice).rating_by(users(:john))
    assert_equal true, books(:alice).rated_by?(users(:john))
    assert_equal false, books(:alice).rated_by?(users(:jane))
  end

  test "rate_it multiple users" do
    books(:alice).rate_it(4, users(:jane))
    books(:alice).rate_it(5, users(:bill))
    assert_equal 4.5, books(:alice).average_rating
    assert_equal 4, books(:alice).rating_by(users(:jane))
    assert_equal 5, books(:alice).rating_by(users(:bill))
    assert_equal false, books(:alice).rated_by?(users(:john))
    assert_equal true, books(:alice).rated_by?(users(:jane))
    assert_equal true, books(:alice).rated_by?(users(:bill))
  end

end
