require File.join(File.dirname(__FILE__), 'test_helper')
require 'date'

class Days360Test < Test::Unit::TestCase

  test "last_day_of_february should tell if it is the last day of february" do
    assert_equal false, Days360::Days360.send(:last_day_of_february?, Date.parse("20012-01-01"))
    assert_equal false, Days360::Days360.send(:last_day_of_february?, Date.parse("20012-02-10"))
    assert_equal false, Days360::Days360.send(:last_day_of_february?, Date.parse("20012-02-28"))
    assert_equal true, Days360::Days360.send(:last_day_of_february?, Date.parse("20012-02-29"))
    assert_equal true, Days360::Days360.send(:last_day_of_february?, Date.parse("2007-02-28"))
    assert_equal false, Days360::Days360.send(:last_day_of_february?, Date.parse("20012-01-31"))
  end

  test "days360 should calculate the correct number of days" do
    assert_equal Days360::Days360.us_method(Date.parse('2012-01-23'), Date.parse('2012-12-31')), 338
    assert_equal Days360::Days360.us_method(Date.parse('2012-03-19'), Date.parse('2012-12-31')), 282
    assert_equal Days360::Days360.us_method(Date.parse('2012-01-01'), Date.parse('2012-12-31')), 360
  end


  test "days360_US should give same result as Open Office Calc" do
    reference_results = read_csv_file_from_data_dir('calc_DAYS360_US.csv')
    result = compare_gem_to_reference(:us_method, reference_results)

    assert_equal 36*36, result[:comparisons], "We expect the same number of comparisons as put into the test data"
    assert result[:differences].eql?(0), "The method should calculate the same results as given by reference implementations"
  end

  test "days360_US should give same result as Microsoft Office Excel" do
    reference_results = read_csv_file_from_data_dir('excel_DAYS360_US.csv')
    result = compare_gem_to_reference(:us_method, reference_results)

    assert_equal 36*36, result[:comparisons], "We expect the same number of comparisons as put into the test data"
    assert result[:differences].eql?(0), "The method should calculate the same results as given by reference implementations"
  end

  test "days360_US should give same result as NASD reference" do
    reference_results = read_csv_file_from_data_dir('NASD_reference_DAYS360_US.csv')
    result = compare_gem_to_reference(:nasd_us_method, reference_results)

    assert_equal 36*36, result[:comparisons], "We expect the same number of comparisons as put into the test data"
    assert result[:differences].eql?(0), "The method should calculate the same results as given by reference implementations"
  end

end
