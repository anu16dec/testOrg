Public class RandomContactFactory
{
    Public Static List<Contact> generateRandomContacts(integer n, String lName)
    {
        List<Contact> contactList = new List<Contact>();
        for(integer i=1; i<=n;i++)
        {
            Contact c = new Contact(firstName = 'test'+i,lastName=lName);
            contactList.add(c);
        }
        return contactList;
    }
}