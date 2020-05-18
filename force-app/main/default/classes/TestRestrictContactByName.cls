@isTest
private class TestRestrictContactByName
{
    @isTest static void TestRestrictContactByName1()
    {
        test.startTest();
        Contact c=new Contact(FirstName='test',LastName='valid');
        insert c;
        test.stopTest();
    }
    
    @isTest static void TestRestrictContactByName2()
    {
        test.startTest();
        Contact c=new Contact(FirstName='test',LastName='INVALIDNAME');
        try
        {
            insert c;
        }
        catch(DMLException e)
        {
            system.debug(e.getDmlMessage(0));
            system.assertEquals(e.getDmlMessage(0),'The Last Name "INVALIDNAME" is not allowed for DML');
        }
        test.stopTest();
    }
}