({
  updateSelectedRows: function(comp, event, helper) {
    var action = comp.get("c.updateById");
    action.setParams({ ids: comp.get("v.selectedIds") });
    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        var result = response.getReturnValue();
        $A.get("e.force:refreshView").fire();
        alert("Compensations updated successfully");
      } else if (state === "INCOMPLETE") {
        alert("Couldn't update compensations: error ocurred in server");
      } else if (state === "ERROR") {
        alert("Couldn't update compensations: error ocurred in server");
        var errors = response.getError();
        if (errors) {
          if (errors[0] && errors[0].message) {
            console.log("Error message: " + errors[0].message);
          }
        } else {
          alert("Couldn't update compensations: error ocurred in server");
        }
      }
    });

    $A.enqueueAction(action);
  }
});