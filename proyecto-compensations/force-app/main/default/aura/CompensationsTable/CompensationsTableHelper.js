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
  }
});