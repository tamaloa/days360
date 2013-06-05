require "days360/version"
require 'date'

module Days360

  class Days360


    ##
    # This method uses the the US/NASD Method (30US/360) to calculate the days between two dates
    #
    # NOTE: to use the reference calculation method 'preserve_excel_compatibility' must be set to false
    # The default is to preserve compatibility. This means results are comparable to those obtained with
    #  Excel or Calc. This is a bug in Microsoft Office which is preserved for reasons of backward compatibility. Open Office Calc also
    # choose to "implement" this bug to be MS-Excel compatible [1].
    #
    # [1] http://wiki.openoffice.org/wiki/Documentation/How_Tos/Calc:_Date_%26_Time_functions#Financial_date_systems
    #
    # Implementation as given by http://en.wikipedia.org/w/index.php?title=360-day_calendar&oldid=546566236
    #
    def self.us_method(date_a, date_b, preserve_excel_compatibility = true)
      day_a = date_a.day
      day_b = date_b.day

      # Step 1 must be skipped to preserve Excel compatibility
      # (1) If both date A and B fall on the last day of February, then date B will be changed to the 30th.
      day_b = 30 if last_day_of_february?(date_a) and last_day_of_february?(date_b) and not preserve_excel_compatibility

      # (2) If date A falls on the 31st of a month or last day of February, then date A will be changed to the 30th.
      day_a = 30 if day_a.eql?(31) or last_day_of_february?(date_a)

      # (3) If date A falls on the 30th of a month after applying (2) above and date B falls on the 31st of a month, then date B will be changed to the 30th.
      day_b = 30 if day_a.eql?(30) and day_b.eql?(31)

      days = (date_b.year - date_a.year)*360 + (date_b.month - date_a.month)*30 + (day_b - day_a)
      return days

    end

    def self.nasd_us_method(date_a, date_b)
      us_method(date_a, date_b, false)
    end

    ##
    # This method uses the the European method (30E/360) to calculate the days between two dates
    #
    # Implementation as given by http://en.wikipedia.org/w/index.php?title=360-day_calendar&oldid=546566236
    #
    def self.eu_method(date_a, date_b)
      day_a = date_a.day
      day_b = date_b.day


      #If either date A or B falls on the 31st of the month, that date will be changed to the 30th;
      day_a = 30 if day_a.eql?(31)
      day_b = 30 if day_b.eql?(31)

      #Where date B falls on the last day of February, the actual date B will be used.
      #This rule is actually only a note and does not change the calculation.

      days = (date_b.year - date_a.year)*360 + (date_b.month - date_a.month)*30 + (day_b - day_a)
      return days

    end

    private

    def self.last_day_of_february?(date)
      last_february_day_in_given_year = Date.new(date.year, 2, -1)
      date.eql?(last_february_day_in_given_year)
    end

  end
end