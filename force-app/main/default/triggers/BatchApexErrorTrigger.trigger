trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
	List<BatchLeadConvertErrors__c> batchRecList = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent br : trigger.new)
    {
    	BatchLeadConvertErrors__c b = new BatchLeadConvertErrors__c();
        b.AsyncApexJobId__c = br.AsyncApexJobId;
        b.Records__c = br.JobScope;
        b.StackTrace__c = br.StackTrace;
        batchRecList.add(b);
    }
    
    if(batchRecList.size() > 0)
    {
        insert batchRecList;
    }
}