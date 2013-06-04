require_relative 'test_helper'

class Days360Test < Test::Unit::TestCase

  test "days360 should calculate the correct number of days" do
    assert_equal days360(Date.parse('2012-01-23'), Date.parse('2012-12-31')), 338
    assert_equal days360(Date.parse('2012-03-19'), Date.parse('2012-12-31')), 282
    assert_equal days360(Date.parse('2012-01-01'), Date.parse('2012-12-31')), 360
  end

end
