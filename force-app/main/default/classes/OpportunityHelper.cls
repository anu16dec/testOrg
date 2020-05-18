public class OpportunityHelper {
    @AuraEnabled public static Opportunity[] loadOpportunityRecords() {
        return [SELECT Name, Amount FROM Opportunity  LIMIT 10];
    }
}