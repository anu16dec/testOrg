@isTest
private class LeadProcessorTest
{
    @isTest static void LeadProcessorTestMethod()
    {
        List<lead> leadList = new List<Lead>();
        for(integer i=1;i<=200;i++)
        {
            Lead l = new Lead(Company='test1', firstName='hello',lastName='world');
            leadList.add(l);
        }
        
        insert leadList;
        
        test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);

        test.stopTest();
        
    }
}