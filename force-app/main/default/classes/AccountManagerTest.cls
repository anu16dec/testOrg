@isTest
Public class AccountManagerTest{

    @isTest static void AccountManagerTestMethod()
    {
        Account a = new Account(Name = 'Acme');
        insert a;
        
        Contact c= new contact(FirstName='Acme',LastName='User', AccountId=a.Id);
        insert c;
        
        restRequest req= new restRequest();
        req.requestUri = 'https://na35.salesforce.com/services/apexrest/Accounts/'+a.Id+'/contacts';
        
        req.HttpMethod = 'GET';
        
        req.params.put('Status','Success');
        
        RestContext.request = req;
        
        Account accountList = AccountManager.getAccount();
        
        system.assertEquals(accountList.Name,'Acme');
        system.assert(accountList.contacts.size()>0);
    }
}