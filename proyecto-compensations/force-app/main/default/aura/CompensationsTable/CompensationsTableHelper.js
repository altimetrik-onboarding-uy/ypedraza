({
  getCompensations: function(component) {
    var action = component.get("c.getCompensations");
    var self = this;
    action.setCallback(this, function(actionResult) {
      component.set("v.compensations", actionResult.getReturnValue());
    });
    $A.enqueueAction(action);
  },
  getCompensationsByType: function(component, type) {
    var action = component.get("c.getByRecordType");
    action.setParams({
      type: component.get("v.type"),
      filterStatus: component.get("v.activeFilterStatus")
    });
    var self = this;
    action.setCallback(this, function(actionResult) {
      component.set("v.compensations", actionResult.getReturnValue());
    });
    $A.enqueueAction(action);
  },
  getCompensationsByStatus: function(component, type) {
    var action = component.get("c.getByStatus");
    action.setParams({
      status: component.get("v.status"),
      filterType: component.get("v.activeFilterType")
    });
    var self = this;
    action.setCallback(this, function(actionResult) {
      component.set("v.compensations", actionResult.getReturnValue());
    });
    $A.enqueueAction(action);
  },
    editRecordEvent: function(){
     var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
      recordId: event.target.id
    });
    editRecordEvent.fire();
},
    checkboxChange: function(component){
            var submitId = [];
    var getAllId = component.find("boxPack");
    if (!Array.isArray(getAllId)) {
      if (getAllId.get("v.value") == true) {
        submitId.push(getAllId.get("v.text"));
      }
    } else {
      for (var i = 0; i < getAllId.length; i++) {
        if (getAllId[i].get("v.value") == true) {
          submitId.push(getAllId[i].get("v.text"));
        }
      }
    }
    component.set("v.selectedIds", submitId);
    },
    handleEvent: function(cmp, event, helper){
         var type = event.getParam("type");
    var status = event.getParam("status");
    var launcher = event.getParam("launcher");

    var activeFilterStatus = cmp.get("v.activeFilterStatus");
    var activeFilterType = cmp.get("v.activeFilterType");

    if (type == "all" && activeFilterStatus == "all") {
      var a = cmp.get("c.doinit");
      $A.enqueueAction(a);
      cmp.set("v.activeFilterType", type);
    } else if (status == "all" && activeFilterType == "all") {
      var a = cmp.get("c.doinit");
      $A.enqueueAction(a);
      cmp.set("v.activeFilterStatus", status);
    } else {
      switch (launcher) {
        case "typeSelect":
          cmp.set("v.type", type);
          cmp.set("v.activeFilterType", type);
          helper.getCompensationsByType(cmp);
          break;
        case "submissionSelect":
          cmp.set("v.status", status);
          cmp.set("v.activeFilterStatus", status);
          helper.getCompensationsByStatus(cmp);
      }
    }
    }
});