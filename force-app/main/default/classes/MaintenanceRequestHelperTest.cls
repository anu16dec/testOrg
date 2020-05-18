@isTest
public class MaintenanceRequestHelperTest {
    
    public static final Integer BULK_COUNT = 300;
    
    @isTest static  void testWorkOrderUpdatesWithNoWorkParts() {
        
        List<Vehicle__c> listOfVehicles = new List<Vehicle__c>();
        List<Case> listOfMaintenanceRequests = new List<Case>();
        List<Work_Part__c> listOfWorkParts = new List<Work_Part__c>();
        List<Product2> listOfEquipments = new List<Product2>();
        
        // Create a Vehicle
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Vehicle__c newFerrari = new Vehicle__c();
            newFerrari.Name = 'Vehicle ' + i;
            listOfVehicles.add( newFerrari );
        }
        
        insert listOfVehicles;
        
        // Create equipments
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Product2 newEquipment = new Product2();
            newEquipment.Name = 'Equipment ' + i;
            newEquipment.IsActive = true;
            newEquipment.Replacement_Part__c = true;
            newEquipment.Maintenance_Cycle__c = 10;
            listOfEquipments.add( newEquipment );
        }
        
        insert listOfEquipments;
        
        // Create Maintenance Requests for every Vehicle
        for ( Integer i = 0 ; i < listOfVehicles.size() ; i ++ ) {
            Vehicle__c vehicle = listOfVehicles.get(i);
            Case newMaintenance = new Case();
            newMaintenance.Type = 'Repair';
            newMaintenance.Status = 'New';
            newMaintenance.Origin = 'Phone';
            newMaintenance.Vehicle__c = vehicle.Id;
            newMaintenance.Equipment__c = listOfEquipments.get(i).Id;
            listOfMaintenanceRequests.add( newMaintenance );
        }
        
        insert listOfMaintenanceRequests;
        
        // Closing the maintenances
        for ( Case maintenanceToUpdate : listOfMaintenanceRequests ) {
            maintenanceToUpdate.Status = 'Closed';
        }
        
        update listOfMaintenanceRequests;
        
        // Start Positive asserts
        for ( Case newMaintenance : [SELECT Date_Reported__c, Equipment__c, Vehicle__c, Date_Due__c, Subject  FROM Case Where Type = 'Routine Maintenance']) {
            System.assertEquals( newMaintenance.Date_Reported__c, System.today() );
            System.assertEquals( newMaintenance.Equipment__c != null, true);
            System.assertEquals( newMaintenance.Subject != null, true);
            System.assertEquals( newMaintenance.Date_Due__c == System.today().addDays( 10 ), true);
        }
        
    }
    
    @isTest static  void testWorkOrderUpdates() {
        
        List<Vehicle__c> listOfVehicles = new List<Vehicle__c>();
        List<Case> listOfMaintenanceRequests = new List<Case>();
        List<Work_Part__c> listOfWorkParts = new List<Work_Part__c>();
        List<Product2> listOfEquipments = new List<Product2>();
        
        // Create a Vehicle
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Vehicle__c newFerrari = new Vehicle__c();
            newFerrari.Name = 'Vehicle ' + i;
            listOfVehicles.add( newFerrari );
        }
        
        insert listOfVehicles;
        
        // Create equipments
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Product2 newEquipment = new Product2();
            newEquipment.Name = 'Equipment ' + i;
            newEquipment.IsActive = true;
            newEquipment.Replacement_Part__c = true;
            newEquipment.Maintenance_Cycle__c = 10;
            listOfEquipments.add( newEquipment );
        }
        
        insert listOfEquipments;
        
        // Create Maintenance Requests for every Vehicle
        for ( Integer i = 0 ; i < listOfVehicles.size() ; i ++ ) {
            Vehicle__c vehicle = listOfVehicles.get(i);
            Case newMaintenance = new Case();
            newMaintenance.Type = 'Repair';
            newMaintenance.Status = 'New';
            newMaintenance.Origin = 'Phone';
            newMaintenance.Vehicle__c = vehicle.Id;
            newMaintenance.Equipment__c = listOfEquipments.get(i).Id;
            listOfMaintenanceRequests.add( newMaintenance );
        }
        
        insert listOfMaintenanceRequests;
        
        // Create a work part for every maintenance request
        for ( Case maintenaceRequest : listOfMaintenanceRequests ) {
            Work_Part__c newWorkPart = new Work_Part__c();
            newWorkPart.Maintenance_Request__c = maintenaceRequest.Id;
            newWorkPart.Equipment__c = maintenaceRequest.Equipment__c;
            newWorkPart.Quantity__c = 10;
            listOfWorkParts.add( newWorkPart );
        }
        
        insert listOfWorkParts;
        
        // Closing the maintenances
        for ( Case maintenanceToUpdate : listOfMaintenanceRequests ) {
            maintenanceToUpdate.Status = 'Closed';
        }
        
        update listOfMaintenanceRequests;
        
        // Start Positive asserts
        for ( Case newMaintenance : [SELECT Date_Reported__c, Equipment__c, Vehicle__c, Date_Due__c, Subject  FROM Case Where Type = 'Routine Maintenance']) {
            System.assertEquals( newMaintenance.Date_Reported__c, System.today() );
            System.assertEquals( newMaintenance.Equipment__c != null, true);
            System.assertEquals( newMaintenance.Subject != null, true);
            System.assertEquals( newMaintenance.Date_Due__c == System.today().addDays( 10 ), true);
        }
        
    }
    
    @isTest static  void testWorkOrderUpdatesNotUpdated() {
        
        List<Vehicle__c> listOfVehicles = new List<Vehicle__c>();
        List<Case> listOfMaintenanceRequests = new List<Case>();
        List<Work_Part__c> listOfWorkParts = new List<Work_Part__c>();
        List<Product2> listOfEquipments = new List<Product2>();
        
        // Create a Vehicle
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Vehicle__c newFerrari = new Vehicle__c();
            newFerrari.Name = 'Vehicle ' + i;
            listOfVehicles.add( newFerrari );
        }
        
        insert listOfVehicles;
        
        // Create equipments
        for ( Integer i = 0 ; i < BULK_COUNT ; i ++ ) {
            Product2 newEquipment = new Product2();
            newEquipment.Name = 'Equipment ' + i;
            newEquipment.IsActive = true;
            newEquipment.Replacement_Part__c = true;
            newEquipment.Maintenance_Cycle__c = 10;
            listOfEquipments.add( newEquipment );
        }
        
        insert listOfEquipments;
        
        // Create Maintenance Requests for every Vehicle
        for ( Integer i = 0 ; i < listOfVehicles.size() ; i ++ ) {
            Vehicle__c vehicle = listOfVehicles.get(i);
            Case newMaintenance = new Case();
            newMaintenance.Type = 'Repair';
            newMaintenance.Status = 'New';
            newMaintenance.Origin = 'Phone';
            newMaintenance.Vehicle__c = vehicle.Id;
            newMaintenance.Equipment__c = listOfEquipments.get(i).Id;
            listOfMaintenanceRequests.add( newMaintenance );
        }
        
        insert listOfMaintenanceRequests;
        
        // Create a work part for every maintenance request
        for ( Case maintenaceRequest : listOfMaintenanceRequests ) {
            Work_Part__c newWorkPart = new Work_Part__c();
            newWorkPart.Maintenance_Request__c = maintenaceRequest.Id;
            newWorkPart.Equipment__c = maintenaceRequest.Equipment__c;
            newWorkPart.Quantity__c = 10;
            listOfWorkParts.add( newWorkPart );
        }
        
        insert listOfWorkParts;
        
        // Closing the maintenances
        for ( Case maintenanceToUpdate : listOfMaintenanceRequests ) {
            maintenanceToUpdate.Status = 'Working';
        }
        
        update listOfMaintenanceRequests;
        
        String routineMaintenance = 'Routine Maintenance';
        
        // Start Negative asserts
        // No maintenance should have been crated
        System.assertEquals( 0, database.countQuery('SELECT count() FROM Case Where Type =: routineMaintenance') );
        
    }    
}