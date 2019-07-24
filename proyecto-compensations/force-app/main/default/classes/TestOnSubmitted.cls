@isTest
public class TestOnSubmitted {
    @isTest static void TestSubmitCompensation() {
		saveRecords();
        Compensation__c savedComp =[select Status__c from Compensation__c where Name = 'TestCompensation'];
         System.assertEquals(savedComp.Status__c,'SUBMITTED');
    }
    
    @isTest static void TestDeleteSubmittedCompensation(){
        Compensation__c comp= saveRecords();
        Test.startTest();
        Database.DeleteResult result = Database.delete(comp, false);
        Test.stopTest();
        
         System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete submitted compensation.',
                             result.getErrors()[0].getMessage());
    }
    
    static Compensation__c saveRecords(){
         Contact ct= new Contact(LastName='ExampleName');
        insert ct;
        Compensation__c comp= new Compensation__c(Name='TestCompensation', Job_Category__c='Junior', Other_details__c='', Location__c='India', Employee__c= ct.Id);
        insert comp;
        return comp;
    }
}