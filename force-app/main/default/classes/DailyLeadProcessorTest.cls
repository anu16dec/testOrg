@isTest
private class DailyLeadProcessorTest
{
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @isTest static void DailyLeadProcessorTestMethod()
    {
        
        List<Lead> LeadList = new List<Lead>();
        for(integer i=1;i<=200;i++)
        {
            Lead l = new Lead();
            l.firstName = 'Hello';
            l.LastName ='Hello';
            l.Company = 'Hello';
            leadList.add(l);
        }
        
        insert leadList;
        
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new DailyLeadProcessor());
    }
}