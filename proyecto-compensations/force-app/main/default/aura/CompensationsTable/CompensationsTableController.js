({
  doinit: function(component, event, helper) {
    helper.getCompensations(component);
  },
  editRecord: function(component, event, helper) {
   helper.editRecordEvent();
  },

  handleAppEvent: function(cmp, event, helper) {
   helper.handleEvent(cmp, event, helper);
  },

  onCheckboxChange: function(component, event, helper) {
		helper.checkboxChange(component);
  }
});