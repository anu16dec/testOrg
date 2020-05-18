public class BoatReviews {

    @AuraEnabled

    public static List<BoatReview__c> getAll (String bId ) {

        

        List<BoatReview__c> boatReviews = [select Id,Name,Comment__c,Rating__c,LastModifiedDate,

                                           CreatedDate,CreatedBy.Name,CreatedBy.Id,CreatedBy.SmallPhotoUrl,CreatedBy.CompanyName 

                                           from BoatReview__c where Boat__c=:bId];

 		return boatReviews;

    }
}