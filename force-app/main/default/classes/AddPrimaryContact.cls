Public class AddPrimaryContact implements Queueable
{
    Public Contact con;
    Public List<String> stateVal;
    
    public AddPrimaryContact(Contact c, List<String> stateAbbr)
    {
        this.con =c;
        this.stateVal = stateAbbr;
    }
    public void execute(QueueableContext context) 
    {
        List<Contact> conList = new List<Contact>();
        
        for(Account a : [Select Name from Account where BillingState IN : stateVal])
        {
            contact c= new contact();
            c = con.clone();
            c.AccountId = a.Id;
            conList.add(c);
        } 
        
        insert conList;
        
    }
}