({
  onChange: function(cmp, evt, helper) {
    var event = $A.get("e.c:TypeSelectionEvent");
      console.log(cmp.find("select").get("v.value"));
      event.setParams({"type": cmp.find("select").get("v.value")}); 
      console.log(event.getParam("type"));
    event.fire();
  }
});