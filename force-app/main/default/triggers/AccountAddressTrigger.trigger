trigger AccountAddressTrigger on Account (before insert, before update) 
{

    for(Account a : trigger.new)
    {
        if(a.Match_Billing_Address__c)
        {
            if(trigger.isInsert)
            {
                a.BillingPostalCode = a.ShippingPostalCode;
            }
            else if(trigger.isUpdate && trigger.newMap.get(a.id).ShippingPostalCode!=trigger.oldMap.get(a.id).ShippingPostalCode)
            {
                a.BillingPostalCode = a.ShippingPostalCode;
            }
        }
    }
}