@isTest
Public class ParkLocatorTest{
    
    @isTest static void ParkLocatorTestMethod()
    {
        test.setMock(WebServiceMock.class, new ParkServiceMock());
        List<String> parkdetails = ParkLocator.country('India');
        system.assertEquals(parkdetails[0],'a');
    }
}