trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> taskList = new List<Task>();
    for(Opportunity o : trigger.new)
    {
        if(trigger.isInsert && o.stageName.equalsIgnoreCase('Closed Won'))
        {
            Task t = new Task();
            t.whatId = o.Id;
            t.Subject = 'Follow Up Test Task';
            taskList.add(t);
        }
        else if(trigger.isUpdate && trigger.newMap.get(o.Id).stageName.equalsIgnoreCase('Closed Won') && trigger.newMap.get(o.Id).stageName!=trigger.oldMap.get(o.Id).stageName)
        {
            Task t = new Task();
            t.whatId = o.Id;
            t.Subject = 'Follow Up Test Task';
            taskList.add(t);
        }
    }
    
    if(taskList.size() > 0 )
    {
        insert taskList;
    }
}