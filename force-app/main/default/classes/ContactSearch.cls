Public class ContactSearch{
    Public static List<Contact> searchForContacts(String a, String b)
    {
        List<Contact> conList = new List<Contact>([Select Name from Contact where LastName=:a AND MailingPostalCode=:b]);
        return conList;
    }
}