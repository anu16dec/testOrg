({
	packItem : function(component, event, helper) {
        	
        var btnVal = event.getSource();
        btnVal.set("v.disabled",true);
        
        var chkBox = component.get("v.item").packed__c = true;
        component.set("v.item",chkBox);
        
	},
})