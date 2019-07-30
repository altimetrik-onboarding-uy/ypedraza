({
    downloadCsv : function(component, event, helper){
        // get the Records [compensation] list
        var stockData = component.get("v.records");
        // call the helper function which "return" the CSV data as a String
        var csv = helper.convertArrayOfObjectsToCSV(component, stockData);
        helper.createDoc(csv);
    },

})