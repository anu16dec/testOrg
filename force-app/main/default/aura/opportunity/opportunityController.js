({
    doInit: function(component, event, helper) {
        var load = component.get("c.loadOpportunityRecords");
        load.setCallback(this, function(result) {
            component.set("v.records", result.getReturnValue());
            component.set("v.sortAsc", true);
            helper.sortBy(component, "Name");
        });
        $A.enqueueAction(load);
    },
    sortByName: function(component, event, helper) {
        helper.sortBy(component, "Name");
    },
    sortByAmount: function(component, event, helper) {
        helper.sortBy(component, "Amount");
    }
})