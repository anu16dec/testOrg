public with Sharing class CampingListController {

    @auraEnabled
    Public static List<Camping_Item__c> getItems(){
        return [Select Id, Quantity__c, Price__c,Packed__c FROM Camping_Item__c];
    }
    
    @auraEnabled
    Public Static Camping_Item__c saveItem(Camping_Item__c items){
        upsert items;
        return items;
    }
}