({
	addAccount : function(component, accountName) {
        var action = component.get("c.createAccount");
        action.setParams({
            accountName: accountName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Save successfully");
            }
            else {
                console.log("Failed with state: " + state);
            }                                                
        });
        $A.enqueueAction(action);        
	}
})