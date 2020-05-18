trigger ProjectTrigger on Project__c (after update) {
    if(trigger.isUpdate)
    {
        BillingCalloutService.callBillingService(trigger.new,trigger.oldMap);
    }
}