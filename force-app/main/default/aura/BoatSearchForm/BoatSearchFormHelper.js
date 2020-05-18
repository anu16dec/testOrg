({
	fetchPickListValues : function(component,Type) {
		var compVal = component.get("c.getSelectOptions");
        var optionValues = [];
        compVal.setCallback(this,function(response){
            if(response.getStatus() == 'SUCCESS'){
                var resp = response.getReturnValue();
                if(resp.length > 0){
                    optionValues.push({
                        class: "optionClass",
                        label: "All Types",
                        value:""
                    });
                 }
                 for (var i = 0; i < allValues.length; i++) {
                    optionValues.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(Type).set("v.options", optionValues);
            }
        });
	}
})