public class ProjectCalloutService {
    @InvocableMethod
    public static void postOpportunityToPMS(List<Id> IdList){
        List<Opportunity> oppList = [ SELECT ID, NAME, ACCOUNT.NAME, CLOSEDATE, AMOUNT FROM OPPORTUNITY WHERE ID =:IdList];
        
        System.enqueueJob( new QueueablePMSCall(oppList) );
    }
    
    public class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts {
        List<Opportunity> oppList;
        
        public QueueablePMSCall(List<Opportunity> oppList) {
            this.oppList = oppList;
        }
        
        public void execute( QueueableContext context ) {
            callMethod( JSON.serialize(oppList) );
        }
    }
    
    @future( callout = true )
    public static void callMethod( String sOpp ) {
        List<Opportunity> FinalList = ( List<Opportunity> )JSON.deserialize( sOpp, List<Opportunity>.class );
        ServiceTokens__c serviceToken = ServiceTokens__c.getvalues('ProjectServiceToken');
        Map<HttpRequest, Id> requests = new Map<HttpRequest, Id>();
        Map<Id, HTTPResponse> responses = new Map<Id, HTTPResponse>();
        HttpRequest request;
        HTTPResponse response;
        
        for ( Opportunity opp : FinalList) {
            
            request = new HttpRequest();
            request.setEndpoint( 'callout:ProjectService'  );
            request.setMethod( 'POST' );
            request.setHeader( 'Content-Type', 'application/json' );
            request.setHeader( 'token', serviceToken.Token__c);
            request.setBody( JSON.serialize( new OpportunityWrapper( opp.Id, opp.Name, opp.Account.Name, String.valueOf( opp.CloseDate ), opp.Amount ) ) );
            requests.put( request, opp.Id );            
        }
        
        Http http = new Http();
        response = new HTTPResponse();
        
        List<Opportunity> OppToUpdateList = new List<Opportunity>();
        for ( HttpRequest req : requests.keySet() ) {
            try {
                response = http.send(req);
                Opportunity opp = new Opportunity(Id = requests.get(req));
                if ( response.getStatusCode() == 201 ) {
                    opp.StageName = 'Submitted Project';
                } else {
                    opp.StageName = 'Resubmit Project';
                }
                OppToUpdateList.add(opp);
            } catch( System.CalloutException e) {
                System.debug(  e.getMessage() );
            }
        }
        
        if ( OppToUpdateList.size() >0) {
            update OppToUpdateList;
        }
    }
    
    public class OpportunityWrapper {
        public String opportunityId;
        public String opportunityName;
        public String accountName;
        public String closeDate;
        public Decimal amount;
        
        public OpportunityWrapper( String opportunityId, String opportunityName, String accountName,
                                  String closeDate, Decimal amount ) {
            this.opportunityId = opportunityId;
            this.opportunityName = opportunityName;
            this.accountName = accountName;
            this.closeDate = closeDate;
            this.amount = amount;
        }
    }
}