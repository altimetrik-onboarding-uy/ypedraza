trigger onSubmitted on Compensation__c (after insert, before delete) {
    if(Trigger.isInsert){
   onSubmittedHandler.submitAfterInsert(Trigger.New);
    }
    else if(Trigger.isDelete){
        onSubmittedHandler.checkSubmittedBeforeDeletion(Trigger.old, Trigger.oldMap );
    
    }
}