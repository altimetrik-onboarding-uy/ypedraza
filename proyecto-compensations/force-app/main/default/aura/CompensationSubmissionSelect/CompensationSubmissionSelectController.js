({
  onChange: function(cmp, evt, helper) {
    var event = $A.get("e.c:TypeSelectionEvent");
      event.setParams({"status": cmp.find("select").get("v.value"), "launcher": "submissionSelect"}); 
    event.fire();
  }
});