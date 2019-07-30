@isTest
public class TestCompensationController {
    @isTest static void TestGetCompensations() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getCompensations();
        System.assert( cList  != null);
        System.assertEquals(cList[0].Name, 'TestCompensationSubmitted');

    }
    @isTest static void TestGetCompensationsByTypeAllStatus() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByRecordType('Salary', 'all');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 2);
        System.assertEquals(cList[0].RecordTypeId, Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Salary').getRecordTypeId());
    }
    
       @isTest static void TestGetCompensationsByTypeAllType() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByRecordType('all', 'submitted');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 1);
           }
        @isTest static void TestGetCompensationsByTypeSubmittedStatus() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByRecordType('Salary', 'submitted');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 1);
        System.assertEquals(cList[0].Status__c,'SUBMITTED' );
    }
    
            @isTest static void TestGetCompensationsByTypeNotSubmittedStatus() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByRecordType('Salary', 'notSubmitted');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 1);
        System.assertEquals(cList[0].Status__c,'REJECTED' );
    }
                @isTest static void TestGetCompensationsByStatusAllType() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByStatus('notSubmitted', 'all');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 3);
       
    }
                    @isTest static void TestGetCompensationsByStatusAllStatus() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByStatus('all', 'salary');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 2);
       
    }
    
     @isTest static void TestGetCompensationsByStatusSubmitted() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByStatus('submitted', 'salary');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 1);
       
    }
    
       @isTest static void TestGetCompensationsByStatusNotSubmitted() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByStatus('notSubmitted', 'study');
            System.assert( cList  != null);
        System.assertEquals(cList.size(), 1);
       
    }
    
        @isTest static void TestGetCompensationsWhenInvalidRequest() {
        saveRecords();
        List<Compensation__c> cList= CompensationController.getByStatus('s', 'rt');
    
        System.assertEquals(cList.size(), 0);
       List<Compensation__c> cList1= CompensationController.getByRecordType('rt', 's');
            System.assertEquals(cList1.size(), 0);
            
             List<Compensation__c> cList2= CompensationController.getByRecordType('all', 's');
            System.assertEquals(cList2.size(), 0);
    }
    
    
    @isTest static void TestUpdateById(){
        List<Compensation__c> result= saveRecords();
        List <String> ids= new List<String>();
        for(Compensation__c c: result){
          ids.add(c.Id);
         
        }
        System.debug(ids);
        List<Compensation__c> comps= CompensationController.updateById(ids);
        for(Compensation__c comp: comps){
            System.assertEquals(comp.Status__c, 'SUBMITTED');
        }
    }
    
        static List<Compensation__c> saveRecords(){
         Contact ct= new Contact(LastName='ExampleName');
        insert ct;
            List<Compensation__c> comps= new List<Compensation__c>();
            String recTypeSalary = Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Salary').getRecordTypeId();
            String recTypeStudy = Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Study').getRecordTypeId();
            String recTypeResearch = Schema.SObjectType.Compensation__c.getRecordTypeInfosByName().get('Research').getRecordTypeId();
          Compensation__c compSalary= new Compensation__c(Name='TestCompensationSubmitted', RecordTypeId = recTypeSalary, Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id, Status__c= 'SUBMITTED');
            Compensation__c compSalaryNS= new Compensation__c(Name='TestCompensationNotSubmitted', RecordTypeId = recTypeSalary, Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id, Status__c= 'REJECTED');
          Compensation__c comp1= new Compensation__c(Name='TestCompensation1', RecordTypeId = recTypeStudy, Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id, Status__c= 'REJECTED');
          Compensation__c comp2= new Compensation__c(Name='TestCompensation2', RecordTypeId = recTypeResearch, Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id, Status__c= 'APPROVED');
  			comps.add(compSalary);
            comps.add(compSalaryNS);
            comps.add(comp1);
            comps.add(comp2);
            insert comps;
            return comps;

}
}