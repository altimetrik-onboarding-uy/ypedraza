({
  onChange: function(cmp, evt, helper) {
    var event = $A.get("e.c:TypeSelectionEvent");
      event.setParams({"type": cmp.find("select").get("v.value")}); 
    event.fire();
  }
});