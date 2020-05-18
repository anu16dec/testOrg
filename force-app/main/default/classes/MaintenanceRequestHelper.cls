public class MaintenanceRequestHelper {
    
    // Retrieve the Cases from the database, in order to retrieve the related Equipments.
    public static List<Case> updatedMaintenanceList( List<Case> maintenanceRequests ) {
        return [ SELECT ID, Equipment__r.Maintenance_Cycle__c, Type, Status, Vehicle__c, Subject, Equipment__c FROM CASE WHERE ID =: maintenanceRequests ];
    }
    
    // Create a new Routine and Update Work Orders
    public static void updateWorkOrders( List<Case> maintenanceRequests, Map<Id, Case> mapOldRecords ) {
        
        List<Case> maintenanceRequestsThatMetTheCriteria = new List<Case>();
        
        // New maintenances.
        List<Case> newMaintenanceListForRoutineCheckup = new List<Case>();
        
        // Iterating to check for those that meet the criteria
        for ( Case maintenanceRequest : updatedMaintenanceList( maintenanceRequests ) ) {
            Case oldMaintenance = mapOldRecords.get( maintenanceRequest.Id );
            
            if ( meetCriteria( maintenanceRequest, oldMaintenance ) && maintenanceRequest.Type == 'Repair' || maintenanceRequest.Type == 'Routine Maintenance' ) {
                maintenanceRequestsThatMetTheCriteria.add( maintenanceRequest );
            }
        }
        
        // Retrieve the mimimun number of cycle days required to close the newest case.
        Map<Id, Decimal> mapMaintenanceIdWithCycleDays = retrieveMinimunCycleDays( maintenanceRequestsThatMetTheCriteria );
        
        for ( Case newMaintenaceRequest : maintenanceRequestsThatMetTheCriteria ) {
            // Create a new routine once the first one is closed, with same vehicle and equipment
            Case routineCheckupMaintenance = new Case();
            routineCheckupMaintenance.Vehicle__c = newMaintenaceRequest.Vehicle__c;
            routineCheckupMaintenance.Equipment__c = newMaintenaceRequest.Equipment__c;
            routineCheckupMaintenance.Type = 'Routine Maintenance';
            routineCheckupMaintenance.Subject = String.isBlank( newMaintenaceRequest.Subject ) ? 'New Routine ' : newMaintenaceRequest.Subject;
            routineCheckupMaintenance.Status = 'New';
            routineCheckupMaintenance.Date_Reported__c = System.today();
            if ( mapMaintenanceIdWithCycleDays.containsKey( newMaintenaceRequest.Id ) ) {
                routineCheckupMaintenance.Date_Due__c = System.today().addDays( ( Integer ) mapMaintenanceIdWithCycleDays.get( newMaintenaceRequest.Id ) );
            } else {
                routineCheckupMaintenance.Date_Due__c = System.today().addDays( ( Integer ) newMaintenaceRequest.Equipment__r.Maintenance_Cycle__c );
            }
            //routineCheckupMaintenance.Old_Case__c  = newMaintenaceRequest.Id;
            newMaintenanceListForRoutineCheckup.add( routineCheckupMaintenance );  
        }
        
        insert newMaintenanceListForRoutineCheckup;
        updateRelatedWorkParts( newMaintenanceListForRoutineCheckup );
    }
    
    // Once the new maintenance records are created, update the work parts
    public static void updateRelatedWorkParts( List<Case> createdMaintenances) {
        
        Map<Id, Id> mapNewMaintenancesWithClosedMaintenances = new Map<Id, Id>();
        for ( Case newMaintenances : createdMaintenances ) {
            //mapNewMaintenancesWithClosedMaintenances.put( newMaintenances.Old_Case__c , newMaintenances.Id );
        }
        
        List<Work_Part__c> workParkList = [ SELECT Id, Maintenance_Request__c FROM Work_Part__c
                                            WHERE Maintenance_Request__c =: mapNewMaintenancesWithClosedMaintenances.keySet() ];
        
        // Query work parts to be updated
        for ( Work_Part__c workPart : workParkList ) {
            //workPart.Maintenance_Request__c = mapNewMaintenancesWithClosedMaintenances.get( workPart.Maintenance_Request__c );
        }
        
        update workParkList;
    }
    
    // Method to check if the cases being updated meet the criteria (They must be closed)
    public static boolean meetCriteria( Case newcase, Case oldMaintenance ) {
        if ( newCase.Status == 'Closed' && oldMaintenance.Status != newCase.Status ) {
            return true;
        }
        return false;
    }
    
    // Use an aggregate function to return the minimum number of cycle days related to the Case
    public static Map<Id, Decimal> retrieveMinimunCycleDays( List<Case> maintenanceRequests ) {
        
        AggregateResult[] listWorkParts = [ SELECT Maintenance_Request__c, MIN( Equipment__r.Maintenance_Cycle__c )
                                            FROM Work_Part__c WHERE Maintenance_Request__c =: maintenanceRequests 
                                            Group By Maintenance_Request__c ];
        
        Map<Id, Decimal> mapWorkPartaAndMaintenanceRecords = new Map<Id, Decimal>();        
        for ( AggregateResult ar : listWorkParts ) {
            mapWorkPartaAndMaintenanceRecords.put( ( Id ) ar.get( 'Maintenance_Request__c' ), ( Decimal ) ar.get( 'expr0' ) );
        }
        
        return mapWorkPartaAndMaintenanceRecords;
    }
    
}