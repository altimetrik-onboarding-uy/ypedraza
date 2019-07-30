@isTest
public class TestSubmissionBatch {
    @isTest static void test(){
         Datetime twoDaysAgo = Datetime.now().addDays(-2);
        List<Compensation__c> compensations = new List<Compensation__c>();
        Contact ct= new Contact(LastName='ExampleName');
        insert ct;
        // insert 50 compensations
        for (Integer i=0;i<50;i++) {
            Compensation__c c= new Compensation__c(name='Cmp '+i, Employee__c= ct.Id,
                Job_Category__c ='Junior', Status__c='Approved', Description__c='BatchTest', Location__c= 'India');
             compensations.add(c);

        }
        insert compensations;
        for (Compensation__c c: compensations){
            Test.setCreatedDate(c.Id, twoDaysAgo);  
        }
    
		
               
        Test.startTest();
        String CRON_EXP = '0 0 0 15 3 ? 2020';
        SubmissionBatch sb = new SubmissionBatch();
          
        Id batchId = Database.executeBatch(sb);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(50, [select count() from Compensation__c where Description__c = 'BatchTest']);
    }
}