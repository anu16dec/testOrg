@isTest
private class TestVerifyDate
{
    @isTest static void testVerify1()
    {
        date d= date.today();
        date d1= date.today().addDays(29);
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(d1,d2);
    }
    
    @isTest static void testVerify2()
    {
        date d= date.today().addDays(29);
        date d1= date.today();
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(lastDay,d2);
    }
    
    @isTest static void testVerify3()
    {
        date d= date.today().addDays(40);
        date d1= date.today();
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(lastDay,d2);
    }
    
    @isTest static void testVerify4()
    {
        date d= date.today();
        date d1= date.today().addDays(40);
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(lastDay,d2);
    }
    
    @isTest static void testVerify5()
    {
        date d= date.today();
        date d1= date.today().addDays(30);
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(lastDay,d2);
        
    }
    
    @isTest static void testVerify6()
    {
        date d= date.today().addDays(30); // 10/07
        date d1= date.today(); //09/07
        date d2 = VerifyDate.CheckDates(d,d1);
        Integer totalDays = Date.daysInMonth(d.year(), d.month());
        Date lastDay = Date.newInstance(d.year(),d.month(), totalDays);
        system.assertEquals(d2,lastDay);
    }
}