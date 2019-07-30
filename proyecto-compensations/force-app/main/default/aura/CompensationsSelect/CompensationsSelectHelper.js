({
	fireEvent : function(cmp) {
		    var event = $A.get("e.c:TypeSelectionEvent");
      event.setParams({"type": cmp.find("select").get("v.value"), "launcher": "typeSelect"}); 
    event.fire();
	}
})