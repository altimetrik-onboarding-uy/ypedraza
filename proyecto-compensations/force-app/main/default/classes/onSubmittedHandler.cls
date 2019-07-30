public class onSubmittedHandler {
    
 
    public static void submitAfterInsert(List<Compensation__c> cList){
        List<Compensation__c> myCompensations= new List<Compensation__c>();
        for(Compensation__c c : cList) {
            Compensation__c updacc=[select id from Compensation__c where id = :c.Id];
   		 updacc.Status__c= 'SUBMITTED';
          myCompensations.add(updacc);  
        }
    update myCompensations;
    }
    
    public static void checkSubmittedBeforeDeletion(List<Compensation__c> cList, Map<Id,Compensation__c> oMap){
                List<Compensation__c> myCompensations= new List<Compensation__c>();
         for(Compensation__c c : cList) {
    if(c.Status__c == 'SUBMITTED'){
        oMap.get(c.Id).addError(
            'Cannot delete submitted compensation.');
    }
    }
    }
}