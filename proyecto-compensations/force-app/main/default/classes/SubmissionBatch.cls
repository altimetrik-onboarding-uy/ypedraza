global class SubmissionBatch implements Database.Batchable<sObject>, Schedulable {
    global Integer recordsProcessed = 0;
    public void execute(SchedulableContext context){
        Database.executeBatch(this);
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches objects to be passed to execute
             return Database.getQueryLocator(
            'SELECT ID, Name, Location__c, CreatedDate, ' +
            'Status__c ' +
            'FROM Compensation__c ' + 
            'Where Status__c != \'Submitted\' and CreatedDate < LAST_N_DAYS:2'
        );

         }
    global void execute(Database.BatchableContext bc, List<Compensation__c> scope){
        // process each batch of records 
        List<Compensation__c> compensations = new List<Compensation__c>();
        for (Compensation__c cmp : scope) {
            cmp.Status__c= 'SUBMITTED';
            cmp.Submitted__c = true;
            recordsProcessed = recordsProcessed + 1;
        }
        update compensations;
    }    
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
               System.debug(recordsProcessed + ' records processed!!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    } 
}