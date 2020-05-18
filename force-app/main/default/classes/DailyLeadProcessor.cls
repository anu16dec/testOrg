global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        List<Lead> leadList = new List<Lead>();
        for(Lead l : [SELECT Id, Name, LeadSource FROM Lead WHERE LeadSource =: ''])
        {
            l.leadSource = 'DreamForce';
            leadList.add(l);
        }
       
       update leadList;
       
  
    }
    
}