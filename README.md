# Days360

Calculates the difference between two dates based on the 360 day year used in interest calculations

[![Build Status](https://travis-ci.org/tamaloa/days360.png?branch=master)](https://travis-ci.org/tamaloa/days360)

## Notes on DAY360 calculations

Discussion of bug in Calc compared to Excel (including several spreadsheet attachments).
https://issues.apache.org/ooo/show_bug.cgi?id=84934
Documentation explaining how calc/excel differ from NASD method
http://wiki.openoffice.org/wiki/Documentation/How_Tos/Calc:_Date_%26_Time_functions#Financial_date_systems

Page explaining different calculation methods and laws (in german)
http://zinsmethoden.de/

ISDA Page containing several documents related to interest calculation (including one document showing different 30/360 30E/360 variants)
http://www.isda.org/c_and_a/trading_practice.html

## Installation

Add this line to your application's Gemfile:

    gem 'days360'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install days360

## Usage

    class MyFinancialCalculation
    include Days360

    def interest_using_US_method(from, till)
      interest_days = days360(from, till)
      #equals
      #interest_days = days360_us(from, till)

      interest = balance * interest_rate * (interest_days / 360)

      interest
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
