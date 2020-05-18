@isTest
private class ProjectCalloutServiceTest {
   public static final Integer BULK_COUNT = 100;
    
    @testSetup
    public static void setupData() {
        ServiceTokens__c newServiceToken = new ServiceTokens__c();
        newServiceToken.Name = 'ProjectServiceToken';
        newServiceToken.Token__c = 'TestingPurpose';
        insert newServiceToken;
    }
    
    @isTest
    public static void testProjectCalloutSuccess() {
        
        List<Account> accountsToCreate = new List<Account>();
        for ( Integer i = 0; i < BULK_COUNT; i++ ) {
            Account newAccount = new Account();
            newAccount.Name = 'Test data ' + i;
            accountsToCreate.add( newAccount );
        }
        
        insert accountsToCreate;
        
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
        for ( Account acc: accountsToCreate ) {
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.CloseDate = Date.today();
            newOpportunity.Name = 'Test Opportunity ' + acc.Name;
            newOpportunity.AccountId = acc.Id;
            newOpportunity.Amount = 100000;
            newOpportunity.StageName = 'Prospecting';
            newOpportunity.Discount_Percent__c = 10;
            opportunitiesToCreate.add( newOpportunity );
        }
        
        insert opportunitiesToCreate;
        
        List<Id> oppIds = new List<Id>();
        for ( Opportunity opp : opportunitiesToCreate ) {
            oppIds.add( opp.Id );
        }
        
        ProjectCalloutService.postOpportunityToPMS( oppIds );
        
        Test.startTest();        
        Test.setMock( HttpCalloutMock.class, new ProjectCalloutServiceMock() );

        System.enqueueJob(new ProjectCalloutService.QueueablePMSCall( opportunitiesToCreate ) );
        ProjectCalloutService.callMethod( JSON.serialize( opportunitiesToCreate ) );        
        Test.stopTest();
        
        for ( Opportunity updatedOpp : [ SELECT StageName FROM Opportunity ] ) {
            System.assertEquals( 'Submitted Project', updatedOpp.StageName , 'something went wrong' ); 
        }
    }
    
    @isTest
    public static void testProjectCalloutFailure() {
        
        List<Account> accountsToCreate = new List<Account>();
        for ( Integer i = 0; i < BULK_COUNT; i++ ) {
            Account newAccount = new Account();
            newAccount.Name = 'Test data ' + i;
            accountsToCreate.add( newAccount );
        }
        
        insert accountsToCreate;
        
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
       
        for ( Account acc: accountsToCreate ) {
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.CloseDate = Date.today();
            newOpportunity.Name = 'Test Opportunity ' + acc.Name;
            newOpportunity.AccountId = acc.Id;
            newOpportunity.Amount = 100000;
            newOpportunity.StageName = 'Prospecting';
            newOpportunity.Discount_Percent__c = 10;
            opportunitiesToCreate.add( newOpportunity );
        }
        
        insert opportunitiesToCreate;
        
        List<Id> oppIds = new List<Id>();
        for ( Opportunity opp : opportunitiesToCreate ) {
            oppIds.add( opp.Id );
        }
        
        ProjectCalloutService.postOpportunityToPMS( oppIds );
        
        Test.startTest();        
        Test.setMock( HttpCalloutMock.class, new ProjectCalloutServiceMockFailure() );
        System.enqueueJob(new ProjectCalloutService.QueueablePMSCall( opportunitiesToCreate ) );
        ProjectCalloutService.callMethod( JSON.serialize( opportunitiesToCreate ) );
        Test.stopTest();
        
        for ( Opportunity updatedOpp : [ SELECT StageName FROM Opportunity ] ) {
            System.assertEquals( 'Resubmit Project', updatedOpp.StageName, 'something went wrong' ); 
        }
    }
}