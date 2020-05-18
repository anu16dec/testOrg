@isTest
private class AddPrimaryContactTest
{
    @isTest static void AddPrimaryContactTestMethod()
    {
        List<Account> accList = new List<Account>();
        for(integer i=1;i<=100;i++)
        {
            Account a = new Account();
            a.Name = 'Acme';
            
            if(i<=50)
            {
                a.BillingState ='NY';
            }
            else
            {
                a.BillingState ='CA';
            }
            accList.add(a);
            
        }
        
        insert accList;
        
        Contact c = new Contact();
        c.firstName = 'acme';
        c.lastName = 'user';
        test.startTest();
        // instantiate a new instance of the Queueable class
        AddPrimaryContact updateJob = new AddPrimaryContact(c,new List<String>{'NY','CA'});
        
        // enqueue the job for processing
        ID jobID = System.enqueueJob(updateJob);
        Test.stopTest();

    }
}