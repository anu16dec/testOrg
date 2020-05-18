public class BillingCalloutService {
    
    Public static void callBillingService(List<Project__c> newProjList,Map<Id,Project__c> oldProjMap)
    {
        List<Project__c> invokeList = new List<Project__c>();
        for(Project__c p :  newProjList)
        {
            if(p.Status__c.equalsIgnoreCase('Billable') && oldProjMap.get(p.Id).status__c != p.status__c)
            {
                invokeList.add(p);
            }
        }
        
        if(invokeList.size() > 0)
        {
            callMethod(JSON.serialize(invokeList));
        }
    }
    
    @future(Callout = true)
    Public static void callMethod(String projList)
    {
        List<Project__c> finalListToProcess = (List<Project__c>) JSON.deserialize(projList,List<Project__c>.class);
        Map<String, String> responseMap = new Map<String, String>();
        ServiceCredentials__c credentials = ServiceCredentials__c.getInstance('BillingServiceCredential');
        
        List<BillingServiceProxy.project> billingRecords = new List<BillingServiceProxy.project>();
        for(Project__c p : finalListToProcess )
        {
            BillingServiceProxy.project proj = new BillingServiceProxy.project();
            proj.username = credentials.username__c;
            proj.password = credentials.password__c;
            proj.projectId = p.ProjectRef__c;
            proj.billAmount = p.Billable_Amount__c;
            
            BillingServiceProxy.InvoicesPortSoap11 invoiceCall = new BillingServiceProxy.InvoicesPortSoap11();
            responseMap.put(p.ProjectRef__c,invoiceCall.billProject(proj));
            
            billingRecords.add(proj);
        }
        
        List<Project__c> projectsToUpdate = new List<Project__c>();
        for ( String projRef: responseMap.keySet() ) {
            if ( responseMap.get(projRef) != null &&  responseMap.get(ProjRef).equalsIgnoreCase('OK') ) {
                Project__c projectToUpdate = new Project__c( ProjectRef__c = projRef);
                projectToUpdate.Status__c = 'Billed';
                projectsToUpdate.add(projectToUpdate);    
            }
        }
        
        if ( projectsToUpdate.size() > 0 ) {
            upsert projectsToUpdate ProjectRef__c;
        }

        
        

    }
    
}