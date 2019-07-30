({
    downloadCsv : function(component, event, helper){
        // get the Records [compensation] list
        var stockData = component.get("v.records");
        // call the helper function which "return" the CSV data as a String
        var csv = helper.convertArrayOfObjectsToCSV(component, stockData);
        if (csv == null){return;}

        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self'; //
        hiddenElement.download = 'Compensations.csv';  // CSV file Name
        document.body.appendChild(hiddenElement); // Required for FireFox browser
        hiddenElement.click(); 
    },

})