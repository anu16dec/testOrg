Public class ContactAndLeadSearch{
    Public Static List<List< SObject>> searchContactsAndLeads(String a)
    {
        List<List<sObject>> searchList = [FIND :a IN ALL FIELDS RETURNING Lead(FirstName,Lastname),
                                         Contact(FirstName,LastName)];
                                         
        return searchList;
    }    
}