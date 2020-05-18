@RestResource(urlMapping='/Accounts/*/contacts')
global with Sharing class AccountManager
{
    @HttpGet
    global static Account getAccount()
    {
        RestRequest req  = restContext.request;
        String temp = req.requestURI.substringBeforeLast('/');
        String AccountId = (temp).substring(temp.lastIndexOf('/')+1);
        
        System.debug(AccountId);
        
        List<Account> accList = [Select Id,Name, (Select Id,Name FROM Contacts) FROM Account WHERE Id=:AccountId];
        
        return accList[0];
        
    }
}