({
  convertArrayOfObjectsToCSV: function(component, objectRecords) {
    var csvStringResult, counter, keys, columnDivider, lineDivider, headers;
    // check if "objectRecords" parameter is null, then return from function
    if (objectRecords == null || !objectRecords.length) {
      return null;
    }

    // store ,[comma] in columnDivider variable for separate CSV values and
    // for start next line use '\n' [new line] in lineDivider variable
    columnDivider = ",";
    lineDivider = "\n";

    // in the keys valriable store fields API Names as a key
    // this labels use in CSV file header
    delete objectRecords[0]["Employee__c"];
    delete objectRecords[0]["RecordTypeId"];
    keys = Object.keys(objectRecords[0]);
    if (keys.length == 10) {
      headers = [
        "Id",
        "Name",
        "Job Category",
        "Location",
        "Amount",
        "Office",
        "Status",
        "Submitted",
        "Compensation Type",
        "Employee Name",
        "Birthdate"
      ];
      keys.push("Employee__r");
    } else if (keys.length == 9) {
      headers = [
        "Id",
        "Name",
        "Job Category",
        "Location",
        "Office",
        "Status",
        "Submitted",
        "Compensation Type",
        "Employee Name",
        "Birthdate"
      ];
      keys.push("Employee__r");
    }

    csvStringResult = "";
    csvStringResult += headers.join(columnDivider);
    csvStringResult += lineDivider;

    for (var i = 0; i < objectRecords.length; i++) {
      counter = 0;

      for (var sTempkey in keys) {
        var skey = keys[sTempkey];
        // add , [comma] after every String value,. [except first]
        if (counter > 0) {
          csvStringResult += columnDivider;
        }
        if (skey == "Employee__r") {
          if (headers.length == 11 && counter % 9 == 0) {
            csvStringResult += '"' + objectRecords[i][skey].Name + '"';
          } else if (headers.length == 10 && counter % 8 == 0) {
            csvStringResult += '"' + objectRecords[i][skey].Name + '"';
          } else if (headers.length == 11 && counter % 10 == 0) {
            if (typeof objectRecords[i][skey].Birthdate !== "undefined") {
              csvStringResult += '"' + objectRecords[i][skey].Birthdate + '"';
            } else {
              csvStringResult += "-";
            }
          } else if (headers.length == 10 && counter % 9 == 0) {
            if (typeof objectRecords[i][skey].Birthdate !== "undefined") {
              csvStringResult += '"' + objectRecords[i][skey].Birthdate + '"';
            } else {
              csvStringResult += "-";
            }
          }
        } else if (skey == "RecordType") {
          csvStringResult += '"' + objectRecords[i][skey].Name + '"';
        } else {
          csvStringResult += '"' + objectRecords[i][skey] + '"';
        }

        counter++;
      }

      csvStringResult += lineDivider;
    }

    return csvStringResult;
  }
});