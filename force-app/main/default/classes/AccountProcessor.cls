Public class AccountProcessor{
    @future
    public static void countContacts(List<Id> AccountIds)
    {
        List<Account> accountList = new List<Account>();
        accountList = [Select Name,Number_of_Contacts__c, (Select Id from Contacts) FROM Account where Id IN:AccountIds];
        for(Account a : accountList)
        {
            a.Number_of_Contacts__c = a.Contacts.size();
            
        }
        
        Update accountList;
        
    }
}