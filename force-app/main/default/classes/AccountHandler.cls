Public class AccountHandler{

    Public static Account insertNewAccount(String accName){
    
        Account a = new Account(Name=accName);
        
        try
        {
            insert a;
        }
        catch(Exception e)
        {
            system.debug(e);
            a = null;
        }
        return a;
    }
}