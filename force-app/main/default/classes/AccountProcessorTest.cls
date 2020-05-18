@isTest
private class AccountProcessorTest
{
    @isTest static void AccountProcessorTestMethod()
    {
        Account a = new Account(Name='abc');
        Account a1 = new Account(Name='abc1');
        insert a;
        insert a1;
        List<Id> accountIds = new List<Id>();
        accountIds.add(a.Id);
        accountIds.add(a1.Id);
        Contact c = new contact(FirstName ='hello',lastName='world',AccountId=a.Id);
        insert c;
        Contact c1 = new contact(FirstName ='hello1',lastName='world1',AccountId=a1.Id);
        insert c1;
        test.startTest();
        AccountProcessor.countContacts(accountIds);
        test.stopTest();
        
    }
}