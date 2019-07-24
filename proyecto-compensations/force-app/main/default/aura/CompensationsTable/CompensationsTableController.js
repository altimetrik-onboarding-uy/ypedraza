({
  doinit: function(component, event, helper) {
    helper.getCompensations(component);
  },
  editRecord: function(component, event, helper) {
    var editRecordEvent = $A.get("e.force:editRecord");
    console.log(event.target.id);
    editRecordEvent.setParams({
    
      recordId: event.target.id
    });
    editRecordEvent.fire();
  },

  handleAppEvent: function(cmp, event, helper) {
    var type = event.getParam("type");
    console.log(event.getParam("type"));
    if (type == "all") {
      var a = cmp.get("c.doinit");
      $A.enqueueAction(a);
    } else {
      cmp.set("v.type", type);
      helper.getCompensationsByType(cmp);
    }
  }
});