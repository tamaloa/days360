require 'test-unit'
require 'csv'
require File.expand_path('../../lib/days360.rb', __FILE__)


def read_csv_file_from_data_dir(file)
  file = File.expand_path("../data/#{file}", __FILE__)
  reference_calculations = CSV.read file
  reference_calculations
end

# The reference result contains a 36x36 date vector and the results calculated by different office suites / methods
# Dates should be ISO-formatted as seen below
#                       | 2007-01-01	| 2007-01-28
# 2007-01-01	| 0                    |	27
# 2007-01-28	| 	-27               |	0
# 2007-01-29	| 	-28	              |	-1
def compare_gem_to_reference(calculation_method, reference_results)
  top_dates = reference_results.first.map{|date| Date.parse(date) if date}
  left_dates = reference_results.map{|line| Date.parse(line[0]) if line[0]}

  differences = same_result = 0

  top_dates.each_with_index do |top_date, top_index|
    next if top_index == 0
    left_dates.each_with_index do |left_date, left_index|
      next if left_index == 0
      gem_result = Days360::Days360.send(calculation_method,left_date, top_date)
      reference_result = reference_results[left_index][top_index].to_i
      equal = reference_result.eql?(gem_result)

      same_result += 1 if equal
      differences += 1 if not equal
      puts "For DAYS360( #{left_date}, #{top_date} ) the result should be #{reference_result} instead of #{gem_result}." if not equal

    end
  end

  p "Compared #{differences + same_result} date combinations to reference results using #{calculation_method} and found #{differences} differences"

  return {:comparisons => (differences + same_result), :differences => differences}
end