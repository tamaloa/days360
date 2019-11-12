class Days360 {
  // This method uses the the US/NASD Method (30US/360) to calculate the days between two dates

  // NOTE: to use the reference calculation method 'preserve_excel_compatibility' must be set to false
  // The default is to preserve compatibility. This means results are comparable to those obtained with
  //  Excel or Calc. This is a bug in Microsoft Office which is preserved for reasons of backward compatibility. Open Office Calc also
  // choose to "implement" this bug to be MS-Excel compatible [1].

  // [1] http://wiki.openoffice.org/wiki/Documentation/How_Tos/Calc:_Date_%26_Time_functions#Financial_date_systems

  // Implementation as given by http://en.wikipedia.org/w/index.php?title=360-day_calendar&oldid=546566236

  static getDaysBetween(date_a, date_b, method = 'US') {
    if(method === 'US_NASD') return days360_US_NASD(date_a, date_b);
    else if(method === 'EU') return days360_EU(date_a, date_b);
    else return days360_US(date_a, date_b);
  }

  static daysInMonth() {
    return 30;
  }
}

function days360_US(date_a, date_b, preserve_excel_compatibility = true) {
  let day_a = date_a.getDate(),
      day_b = date_b.getDate();

  // Step 1 must be skipped to preserve Excel compatibility
  // (1) If both date A and B fall on the last day of February, then date B will be changed to the 30th.

  if(is_last_day_of_february(date_a) &&
     is_last_day_of_february(date_b) &&
     !preserve_excel_compatibility) {
       day_b = 30;
     }

  // (2) If date A falls on the 31st of a month or last day of February, then date A will be changed to the 30th.
  if(day_a === 31 || is_last_day_of_february(date_a)) day_a = 30;

  // (3) If date A falls on the 30th of a month after applying (2) above and date B falls on the 31st of a month, then date B will be changed to the 30th.
  if(day_a === 30 && day_b === 31) day_b = 30;

  days = (date_b.getYear() - date_a.getYear()) * 360 + (date_b.getMonth() - date_a.getMonth()) * 30 + (day_b - day_a);

  return days;
}

function days360_US_NASD(date_a, date_b) {
  return days360_US(date_a, date_b, false);
}


//
// This method uses the the European method (30E/360) to calculate the days between two dates

// Implementation as given by http://en.wikipedia.org/w/index.php?title=360-day_calendar&oldid=546566236


function days360_EU(date_a, date_b) {
  let day_a = date_a.getDate(),
      day_b = date_b.getDate();

  //If either date A or B falls on the 31st of the month, that date will be changed to the 30th;
  if(day_a === 31) day_a = 30;
  if(day_b === 31) day_a = 30;


  //Where date B falls on the last day of February, the actual date B will be used.
  //This rule is actually only a note and does not change the calculation.

  days = (date_b.getYear() - date_a.getYear()) * 360 + (date_b.getMonth() - date_a.getMonth()) * 30 + (day_b - day_a);

  return days;
}

function is_last_day_of_february(date) {
  last_february_day_in_given_year = (new Date(date.getYear(), 2, 0));
  return Date.parse(last_february_day_in_given_year) === Date.parse(date);
}
