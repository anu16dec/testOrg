Public class leadprocessorBatch
{
    public static void updateLeads(List<Lead> records){
        // process each batch of records
        
        for(Lead l : records)
        {
            l.leadSource = 'Dreamforce';
        }
        
        update records;
    }    

}