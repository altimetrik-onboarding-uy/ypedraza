@isTest
public class TestCompensationController {
    @isTest static void TestGetCompensations() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getCompensations();
        System.assert( cList  != null);
        System.debug(cList[0]);
        System.assertEquals(cList[0].Name, 'TestCompensation');

    }
    @isTest static void TestGetCompensationsByType() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByRecordType('Salary');
            System.assert( cList  != null);
        System.assertEquals(cList[0].RecordTypeId, Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Salary').getRecordTypeId());
    }
    
        static Compensation__c saveRecords(){
         Contact ct= new Contact(LastName='ExampleName');
        insert ct;
            String recType = Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Salary').getRecordTypeId();
          Compensation__c comp= new Compensation__c(Name='TestCompensation', RecordTypeId = recType, Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id);
        insert comp;
        return comp;
    }
}