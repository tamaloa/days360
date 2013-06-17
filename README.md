# Days360

Calculates the difference between two dates based on the 360 day year used in interest calculations.

This gems aims to provide full compatibility to calculations based on Excel or Calc. The testsuite thus uses over a thousand date combinations especially picked to highlight problems in the days360 calculation. The reference values were calculated with different office suites using their provided methods (more information in test/data).
Additional calculation methods are also provided. See the Notes section to learn more about the different calculation methods and their history.

The following table gives an overview on which functions are supported and what their equivalents in Excel or Calc are.


|                     Method                   |            days360 gem            |           Excel            |            Calc            |
|----------------------------------------------|-----------------------------------|----------------------------|----------------------------|
| US/NASD Method (30US/360) (Excel compatible) | days360(date_a, date_b)           | DAYS360(date_a, date_b)    | DAYS360(date_a, date_b)    |
| US/NASD Method (30US/360)                    | days360(date_a, date_b, :US_NASD) | not available              | not available              |
| European method (30E/360)                    | days360(date_a, date_b, :EU)      | DAYS360(date_a, date_b, 1) | DAYS360(date_a, date_b, 1) |


[![Build Status](https://travis-ci.org/tamaloa/days360.png?branch=master)](https://travis-ci.org/tamaloa/days360) tested on all major ruby versions.


## Installation

Add this line to your application's Gemfile:

    gem 'days360'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install days360

## Usage
```ruby

    class MyFinancialCalculation
    include Days360

    def interest_using_US_method(from, till)
      interest_days = days360(from, till)
      #equals
      #interest_days = days360_us(from, till)

      interest = balance * interest_rate * (interest_days / 360)

      interest
    end

```

## Notes on DAY360 calculations

Nowadays it seems senseless to calculate interest based on some fictional year instead of simply using the number of days between two dates. The reason (i believe) for different calculation methods to still be in use are:

* history - Before we had computers it was hard calculating interest to the real number of days :) 
* legacy data/calculations - Changing the calculation would make "older" calculations look wrong. Thats also the reason why Excel and Calc actually stick to a buggy version of DAYS360
* Comparison - Comparing interest from different years and months is easier using days360 as all months have the same length. Thus the interest for the same amount of mony does not differ from month to month or in between years (remember leap years!)

Discussion of bug in Calc compared to Excel (including several spreadsheet attachments).
https://issues.apache.org/ooo/show_bug.cgi?id=84934

Documentation explaining how calc/excel differ from NASD method
http://wiki.openoffice.org/wiki/Documentation/How_Tos/Calc:_Date_%26_Time_functions#Financial_date_systems

Page explaining different calculation methods and laws (in german)
http://zinsmethoden.de/

ISDA Page containing several documents related to interest calculation (including one document showing different 30/360 30E/360 variants)
http://www.isda.org/c_and_a/trading_practice.html

## Contributing

There are a huge amount of different calculation methods out there (see ISDA page for a beginning). If you need a different one you are invited to add it. Please make sure you have some kind of documentation and ideally a test vector (see test/data) with reference results.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
